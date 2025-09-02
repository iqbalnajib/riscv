`include "maindec.sv"
`include "aludec.sv"

module controller(
		input  logic [6:0] op,
		input  logic [2:0] func3,
		input  logic func7b5,
		input  logic zero,
		output logic [1:0] pcsrc,
		output logic reg_write,
		output logic mem_write,
		output logic [1:0] imm_src,
		output logic alu_src,
		output logic [1:0] result_src,
		output logic [2:0] alu_control
	);

	logic [1:0] alu_op;

	maindec u_maindec(
		.alu_op    (alu_op),
		.zero (zero),
		.alu_src   (alu_src),
		.imm_src   (imm_src),
		.mem_write (mem_write),
		.op        (op),
		.reg_write (reg_write),
		.result_src(result_src),
		.pcsrc(pcsrc)
	);

	aludec u_aludec(
		.alu_control(alu_control),
		.alu_op     (alu_op),
		.func3      (func3),
		.func7b5    (func7b5),
		.op         (op)
	);
endmodule
