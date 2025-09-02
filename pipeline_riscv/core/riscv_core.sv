`include "datapath.sv"
`include "controller.sv"

module riscv_core (
		input logic clk, reset,
		input logic [31:0] instrF,
		input logic [31:0] readdataM,
		output logic [31:0] pcF,
		output logic mem_write,
		output logic [31:0] writedataM,
		output logic [31:0] aluresultM
	);

	logic reg_write;
	logic [2:0] alu_control;
	logic [1:0] imm_src;
	logic alu_src;
	logic [1:0] result_src;
	logic zero;
	logic [1:0] pcsrc;
	logic [31:0] instrD;

	datapath u_datapath(
		.clk(clk),
		.reset(reset),
		.reg_write(reg_write),
		.imm_src(imm_src),
		.alu_src(alu_src),
		.result_src(result_src),
		.alu_control(alu_control),
		.pcsrc(pcsrc),
		.pcF(pcF),
		.instrF(instrF),
		.readdataM(readdataM),
		.instrD(instrD),
		.zero(zero),
		.writedataM(writedataM),
		.aluresultM(aluresultM));

	controller u_controller(
		.op(instrD[6:0]),
		.func3(instrD[14:12]),
		.func7b5(instrD[30]),
		.zero(zero),
		.pcsrc(pcsrc),
		.mem_write(mem_write),
		.reg_write(reg_write),
		.imm_src(imm_src),
		.alu_src(alu_src),
		.result_src(result_src),
		.alu_control(alu_control));

endmodule