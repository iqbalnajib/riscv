module imem (
		input logic [31:0] a,
		output logic [31:0] rd
	);
	
	logic [31:0] RAM[64];

	assign rd = RAM[a[31:2]];
	
	initial $readmemh("../riscvtest.txt", RAM);
endmodule
