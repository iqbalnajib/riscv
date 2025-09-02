//`include "datapath.sv"
//`include "controller.sv"

module riscvsingle(
		input logic clk,
		input logic reset,
		input logic [31:0] Instr,
		input logic [31:0] ReadData,
		output logic [31:0] PC,
		output logic MemWrite,
		output logic [31:0] ALUResult,
		output logic [31:0] WriteData
		);

	logic ALUSrc, RegWrite, Zero, PCSrc;
	logic [1:0] ResultSrc, ImmSrc;
	logic [2:0] ALUControl;

	controller cunit(
					.op(Instr[6:0]), 
					.funct3(Instr[14:12]), 
					.funct7b5(Instr[30]), 
					.Zero(Zero), 
					.ResultSrc(ResultSrc), 
					.MemWrite(MemWrite), 
					.PCSrc(PCSrc), 
					.ALUSrc(ALUSrc), 
					.RegWrite(RegWrite), 
					.ImmSrc(ImmSrc), 
					.ALUControl(ALUControl)
					);

	datapath dataunit(
					.clk(clk), 
					.reset(reset), 
					.ResultSrc(ResultSrc), 
					.PCSrc(PCSrc), 
					.ALUSrc(ALUSrc), 
					.RegWrite(RegWrite), 
					.ImmSrc(ImmSrc), 
					.ALUControl(ALUControl), 
					.Instr(Instr), 
					.ReadData(ReadData), 
					.Zero(Zero), 
					.PC(PC),
					.ALUResult(ALUResult), 
					.WriteData(WriteData)
					);

endmodule

