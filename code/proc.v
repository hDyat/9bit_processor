module proc(Clock, Resetn, Run, DIN, Done, ADDR, DOUT, W);
	input Clock, Resetn, Run;
	input [8:0] DIN;
	output Done;
	output [8:0] ADDR, DOUT;
	output W;
	
	parameter T0 = 3'b000, T1 = 3'b001, T2 = 3'b010, T3 = 3'b011, T4 = 3'b100, T5 = 3'b101;
	parameter mv = 3'b000, mvi = 3'b001, add = 3'b010, sub = 3'b011, ld = 3'b100, st = 3'b101, mvnz = 3'b110;
	
	reg [0:7] Rin, Rout;
	reg Ain, IRin, AddSub, Gin, Gout, DINout, incr_pc, ADDR_in, DOUT_in, W_D;
	reg [3:0] Tstep_Q, Tstep_D;
	reg Done;
	reg [8:0] BusWires;
	
	wire [1:9] IR;
	wire [0:7] Xreg, Yreg;
	wire [2:0] I;
	wire [2:0] X, Y;
	wire W;
	
	wire [8:0] R7, R6, R5, R4, R3, R2, R1, R0, A, G, AddSub_result, ADDR, DOUT;
	wire [9:0] Sel;
	
	assign I = IR[1:3];
	assign X = IR[4:6];
	assign Y = IR[7:9];
	dec3to8 decX (X, 1'b1, Xreg);
	dec3to8 decY (Y, 1'b1, Yreg);
	
	//Control FSM state table
	always @ (Tstep_Q, Run, Done)
	begin
		case (Tstep_Q)
			T0: if(!Run) Tstep_D = T0;
				 else Tstep_D = T1;
			T1: Tstep_D = T2;
			T2: Tstep_D = T3;
			T3: if (Done) 	Tstep_D = T0;
				 else		Tstep_D = T4;
			T4: Tstep_D = T5;
			T5: Tstep_D = T0;
			default:	Tstep_D = 4'bxxxx;
		endcase
	end 
	
	//Control FSM outputs
	always @ (Tstep_Q or I or Xreg or Yreg or G)
	begin
		IRin = 1'b0;
		Rin = 1'b0;
		Rout = 1'b0;
		DINout = 1'b0;
		AddSub = 1'b0;
		Ain = 1'b0;
		Gin = 1'b0;
		Gout = 1'b0;
		Done = 1'b0;
		incr_pc = 1'b0;
		ADDR_in = 1'b0;
		DOUT_in = 1'b0;
		W_D = 1'b0;
		
		case (Tstep_Q)
			T0: 
			begin
				if(!Run) incr_pc = 1'b0;
				else incr_pc = 1'b1;
				Rout[7] = 1'b1;
				ADDR_in = 1'b1;
			end
			T1: ; //wait cycle for synchronous memory
			T2: //store DIn in IR in time step 2
			begin
				IRin = 1'b1;
			end
			T3: //define signals in time step 3
				case (I)
					mv: 	begin
								Rin = Xreg;
								Rout = Yreg;
								Done = 1'b1;
							end 
					mvi:	begin
								incr_pc = 1'b1;
								Rout[7] = 1'b1;
								ADDR_in = 1'b1;
							end
					add:	begin
								Ain = 1'b1;
								Rout = Xreg;
							end 
					sub:	begin
								Rout = Xreg;
								Ain = 1'b1;
							end
					ld, st:	begin
									Rout = Yreg;
									ADDR_in = 1'b1;
								end
					mvnz:	begin
								if(G != 0)
								begin
									Rout = Yreg;
									Rin = Xreg;
								end
								Done = 1'b1;
							end
					default: ;
				endcase
			T4: //define signals in time step 4
				case (I)
					mvi: ;
					add:	begin
								Rout = Yreg;
								Gin = 1'b1;
							end 
					sub:	begin
								Rout = Yreg;
								Gin = 1'b1;
								AddSub = 1'b1;
							end 
					ld:	;
					st:	begin
								Rout = Xreg;
								DOUT_in = 1'b1;
								W_D = 1'b1;
							end
					default: ;
				endcase
			T5: //define signals in time step 5
				case (I)
					mvi:	begin
								DINout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
					add:	begin
								Gout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
					sub:	begin
								Gout = 1'b1;
								Rin = Xreg;
								Done = 1'b1;
							end
					ld:	begin
								Rin = Xreg;
								DINout = 1'b1;
								Done = 1'b1;
							end
					st:	begin
								Done = 1'b1;
							end
					default: ;
				endcase 
			default: ;
		endcase 
	end

	//Control Fsm flip-flops
	always @ (posedge Clock, posedge Resetn)
		if (Resetn)
			Tstep_Q <= T0;
		else
			Tstep_Q <= Tstep_D;
	
	regn reg_0 (BusWires, Rin[0], Clock, R0);
	regn reg_1 (BusWires, Rin[1], Clock, R1);
	regn reg_2 (BusWires, Rin[2], Clock, R2);
	regn reg_3 (BusWires, Rin[3], Clock, R3);
	regn reg_4 (BusWires, Rin[4], Clock, R4);
	regn reg_5 (BusWires, Rin[5], Clock, R5);
	regn reg_6 (BusWires, Rin[6], Clock, R6);
	//regn reg_7 (BusWires, Rin[7], Clock, R7);
	program_counter pc7(
		.clock(Clock),
		.reset(Resetn),
		.E(incr_pc),
		.L(Rin[7]),
		.PC(BusWires),
		.Q(R7));
	
	
	regn reg_IR (DIN, IRin, Clock, IR);
	regn reg_A (BusWires, Ain, Clock, A);
	regn reg_G (AddSub_result, Gin, Clock, G);
	
	regn reg_ADDR (BusWires, ADDR_in, Clock, ADDR);
	regn reg_DOUT (BusWires, DOUT_in, Clock, DOUT);
	
	regw reg_W (Clock, W_D, W);
	
	adder_subtractor addsub (AddSub, A, BusWires, AddSub_result);
	
	assign Sel = {Rout, Gout, DINout};
	
	always @ (*)
		case (Sel)
			10'b10_0000_0000 : BusWires = R0;
			10'b01_0000_0000 : BusWires = R1;
			10'b00_1000_0000 : BusWires = R2;
			10'b00_0100_0000 : BusWires = R3;
			10'b00_0010_0000 : BusWires = R4;
			10'b00_0001_0000 : BusWires = R5;
			10'b00_0000_1000 : BusWires = R6;
			10'b00_0000_0100 : BusWires = R7;
			10'b00_0000_0010 : BusWires = G;
			10'b00_0000_0001 : BusWires = DIN;
			default : BusWires = 9'bxxxxxxxxx;
		endcase
		
endmodule