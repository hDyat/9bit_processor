`timescale 1ns / 1ps

module testbench ();
	
	reg clock;
	reg reset;
	reg run;
	
	wire [8:0] leds;
	wire done;
	
	part3 DUT (
		.clock(clock),
		.reset(reset),
		.run(run),
		.leds(leds),
		.done(done));
		
	always #10 clock = ~clock;
	
	initial
	begin
		clock = 1'b1;
		reset = 1'b1;
		run = 1'b0;
		#20 reset = 1'b0;
		#10 run = 1'b1;
	end

endmodule