module part3 (clock, reset, run, leds, done);
	input clock;
	input reset;
	input run;
	output [8:0] leds;
	output done;
	
	wire [8:0] ADDR, DOUT, DIN;
	wire W, Run;
	
	regw U3 (
		.clock(CLOCK_50),
		.en(run),
		.q(Run));
	//processor instantiate
	proc U0 (
		.Clock(clock),
		.Resetn(reset),
		.Run(Run),
		.DIN(DIN),
		.Done(done),
		.ADDR(ADDR),
		.DOUT(DOUT),
		.W(W));
	
	wire wren, len;
	assign wren = W & ~(ADDR[8] | ADDR[7]);
	assign len = W & ~(ADDR[8] | ~ADDR[7]);
	
	ram128x9 U1 (
		.address(ADDR[6:0]),
		.clock(clock),
		.data(DOUT),
		.wren(wren),
		.q(DIN));
		
	regn U2 (
		.R(DOUT),
		.Rin(len),
		.Clock(clock),
		.Q(leds));
	
	

endmodule