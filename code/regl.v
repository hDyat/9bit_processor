module regl (clock, en, data, q);
	input clock;
	input en;
	input [8:0] data;
	output [8:0] q;
	
	reg [8:0] q;
	
	always @ (posedge clock)
		if(en)
			q <= data;
		else
			q <= 8'b0;
endmodule