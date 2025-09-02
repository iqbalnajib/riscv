//`include "maindec.sv"
//`include "aludec.sv"

module controller(
		input logic [6:0] op,
		input logic [2:0] funct3,
		input logic funct7b5,
		input logic Zero,
		output logic [1:0] ResultSrc,
		output logic MemWrite,
		output logic PCSrc,
		output logic ALUSrc,
		output logic RegWrite,
		output logic [1:0] ImmSrc,
		output logic [2:0] ALUControl
		);

	logic [1:0] ALUOp;
	logic Branch, Jump;

	maindec md( // ALUOp to set the ALU operation, while other control signals are to determine data flow in DPU)
			.op(op),
			.RegWrite(RegWrite),
			.ImmSrc(ImmSrc),
			.ALUSrc(ALUSrc),
			.MemWrite(MemWrite),
			.ResultSrc(ResultSrc),
			.Branch(Branch),
			.ALUOp(ALUOp),
			.Jump(Jump)
			);
//			ResultSrc, 
//			MemWrite, 
//			Branch, 
//			ALUSrc, 
//			RegWrite, 
//			Jump, 
//			ImmSrc, 
//			ALUOp);

	aludec ad(
			.opb5(op[5]),
			.funct3(funct3),
			.funct7b5(funct7b5),
			.ALUOp(ALUOp),
			.ALUControl(ALUControl)
			);
	//		op[5], 
	//		funct3, 
	//		funct7b5, 
	//		ALUOp, 
	//		ALUControl);

	assign PCSrc = Branch & Zero | Jump; // Select PC of Jump/Branch command instead of regular line-by-line PC
endmodule

