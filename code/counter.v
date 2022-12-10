module counter (Clock, Reset, Q);
	input Clock, Reset;
	output reg [4:0] Q;
	
	always @ (posedge Clock, posedge Reset)
		if (Reset)
			Q <= 0;
		else
			Q <= Q + 1;
endmodule