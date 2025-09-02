module regfile(
		input  logic clk,
		input  logic we3,
		input  logic [4:0] a1, a2, a3,
		input  logic [31:0] wd3,
		output logic [31:0] rd1, rd2);

	logic [31:0] rf [32];
	
	initial begin
		foreach(rf[i])
			rf[i] = 0;
		rf[4] = 32'habcd;
		rf[5] = 32'hdcba;
		rf[6] = 32'h10;
		rf[9] = 32'h10000000;
	end

	// write rf
	always @(negedge clk)      // So that operation doesnt clash (Read/Write Operation)
		if(we3) rf[a3] <= wd3;

	// read rf
//	always @(negedge clk) begin
//	rd1 <= (a1 != 0) ? rf[a1] : 0;
//	rd2 <= (a2 != 0) ? rf[a2] : 0; end 

	assign rd1 <= (a1 != 0) ? rf[a1] : 0; 
	assign rd2 <= (a2 != 0) ? rf[a2] : 0;

endmodule
