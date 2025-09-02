`include "chiptop.sv"

module test();
	timeunit 1ns;
	timeprecision 1ps;
	
	parameter CLK_CYCLE = 100;

	logic clk;
	logic reset;

	initial begin
		clk = 0;
		forever #(CLK_CYCLE/2) clk = ~clk;
	end

	initial begin
		reset = 0;
		@(posedge clk) reset = 1;
		repeat(5) @(posedge clk);
		@(posedge clk) reset = 0;
	end

	initial begin
		@(negedge reset);
		repeat(64)
			@(posedge clk); // next_pc <= next_pc + 4;
		#500;
		$finish();
	end

`ifdef VCS
	initial begin
		$fsdbDumpfile("./wave.fsdb");
		$fsdbDumpvars("+all");
		$fsdbDumpMDA(0, test);
		$fsdbDumpSVA();
	end
`endif

	chiptop i_chiptoo(clk, reset);

endmodule