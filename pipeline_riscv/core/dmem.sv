module dmem (
		input logic clk, we,
		input logic [31:0] a, wd,
		output logic [31:0] rd
	);
	
	logic [31:0] RAM[64];

	// read
	assign rd = RAM[a[31:2]];
	
	// write
	always @(posedge clk)
		if(we) RAM[a[31:2]] <= wd;
	
	initial $readmemh("../riscvdmem.txt", RAM);
endmodule
