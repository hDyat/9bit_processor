module program_counter 
#(parameter n = 9)
(
	clock,
	reset,
	E,
	L, 
	PC,
	Q
);
	
	input clock; 
	input reset;
	input E; 
	input L;
	input [n-1:0] PC;
	output reg [n-1:0] Q;
	
	always @ (posedge clock)
		if (reset)
			Q <= 9'h0;
		else if (L)
			Q <= PC;
		else if (E)
			Q <= Q + 9'h1;
	
	
// ****old code ****	//
//	reg [n-1:0] q;
//	reg [n-1:0] C;
//	always @ (posedge clock, posedge reset)
//		if (reset)
//			q <= 0;
//		else
//			if(E)
//				q <= C;
//			else if (L)
//				q <= PC;
//	
//	always @ (posedge clock, posedge reset)
//		if (reset)
//			C <= 0;
//		else if (E)
//			C <= C + 9'b1;
//		else if (L)
//			C <= PC;
//			
//	assign Q = q;
endmodule