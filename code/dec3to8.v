module dec3to8 (W, En, Y);
	input [2:0] W;
	input En;
	output [0:7] Y;
	reg [0:7] Y;
	
	always @ (W or En)
	begin
		if (En)
			case (W)
				3'b000	: Y = 8'b1000_0000;
				3'b001 	: Y = 8'b0100_0000;
				3'b010 	: Y = 8'b0010_0000;
				3'b011 	: Y = 8'b0001_0000;
				3'b100  : Y = 8'b0000_1000;
				3'b101  : Y = 8'b0000_0100;
				3'b110  : Y = 8'b0000_0010;
				3'b111  : Y = 8'b0000_0001;
			endcase
		else
			Y = 8'b0000_0000;
	end 
		
endmodule