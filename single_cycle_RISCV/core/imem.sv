//`include "riscvtest.txt"
module imem(
		input logic [31:0] a,
		output logic [31:0] rd
		);

	logic [31:0]RAM[63:0]; // 64 arrays of 32bit data

	initial
		$readmemh("../riscvtest.txt", RAM);

		assign rd = RAM[a[31:2]]; // Word alligned (Check Balik Explaination DIa)
endmodule

