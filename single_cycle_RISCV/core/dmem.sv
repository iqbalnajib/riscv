module dmem(
		input logic clk,
		input logic we,
		input logic [31:0] a,
		input logic [31:0] wd,
		output logic [31:0] rd
		);

	logic [31:0] RAM [63:0]; // 32 bitwide data, each kept in 64 addresses array

	assign rd = RAM[a[31:2]]; // Word-based memory, Start read from RAM[1], 2LSB must be in mult of 4 (1 word = 4bytes) 

	always_ff@(posedge clk) 
	begin if (we == 1) RAM[a[31:2]] <= wd;
	 else RAM[a[31:2]] <= 0; end
	

endmodule


