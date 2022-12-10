module regw (clock, en, q);
	input clock;
	input en;
	output q;
	
	reg q;
	always @ (posedge clock)
		if (en)
			q <= 1'b1;
		else
			q <= 1'b0;

endmodule