module adder_subtractor (AddSub, A, B, Result);
	input AddSub;
	input [8:0] A, B;
	output reg [8:0] Result;
	
	always @ (AddSub, A, B)
	if (AddSub)
		Result <= A - B;
	else
		Result <= A + B;
endmodule