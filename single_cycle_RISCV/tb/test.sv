//`include "top.sv"

module test();
		logic clk;
		logic reset;
		
		logic [1:0] ResultSrc;
		logic PCSrc;
		logic ALUSrc;
		logic RegWrite;
		logic [1:0] ImmSrc;
		logic [2:0] ALUControl; 
		logic [31:0] Instr;
		logic [31:0] ReadData;
		logic Zero;
		logic [31:0] PC;
		logic [31:0] ALUResult;
		logic [31:0] WriteData;
 

	top dut(
			.clk(clk),
			.reset(reset)
		   );

	`ifdef VCS
	initial begin
			$fsdbDumpfile("./wave.fsdb");
			$fsdbDumpvars("+all");
			$fsdbDumpMDA(0, test);
			$fsdbDumpSVA();
			end
	`endif

	initial begin
	clk = 0;
	forever #100 clk = ~clk;
	end
	
	initial begin 
		reset = 0;
		#25; reset = 1;
		//@(posedge clk) reset = 0;
		//@(posedge clk) reset = 1;
		repeat(40) @(posedge clk);
		@(posedge clk) reset = 1;
		$finish();
		end
//	initial begin
//	reset = 0;
//	#50;
//	always_ff@(posedge clk)
//		begin
//		if(MemWrite == 1) begin
//			if(DataAdr === 0 & WriteData === 25) begin
//			$display("Simulation succeed");
//			$stop; end
//			else if (DataAdr !== 96) begin // Find out why 96
//			$display("Simulation failed");
//			$stop; end
//			end
//		end
endmodule

