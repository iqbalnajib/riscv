`include "imem.sv"
`include "dmem.sv"
`include "riscv_core.sv"

module chiptop (
		input logic clk, reset
	);

	logic [31:0] pcF;
	logic [31:0] instrF;
	logic [31:0] aluresultM;
	logic mem_write;
	logic [31:0] writedataM, readdataM;

	riscv_core u_riscv_core(
		.clk(clk),
		.reset(reset),
		.pcF(pcF),
		.instrF(instrF),
		.writedataM(writedataM),
		.readdataM(readdataM),
		.mem_write(mem_write),
		.aluresultM(aluresultM));
	
	imem u_imem(
		.a(pcF),
		.rd(instrF));
	
	dmem u_dmem(
		.clk(clk),
		.we(mem_write),
		.a(aluresultM),
		.wd(writedataM),
		.rd(readdataM));
endmodule