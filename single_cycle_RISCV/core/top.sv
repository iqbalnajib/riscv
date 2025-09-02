//`include "riscvsingle.sv"

module top(
		input logic clk,
		input logic reset
//		output logic [31:0] WriteData,
//		output logic [31:0] DataAdr,
//		output logic MemWrite
		);

	logic [31:0] PC, Instr, ReadData, DataAdr, WriteData; 
	logic MemWrite;

	// Connect CPU and Memory 

	riscvsingle rvsingle(
			.clk(clk),
			.reset(reset),
			.Instr(Instr),
			.ReadData(ReadData),
			.PC(PC),
			.MemWrite(MemWrite),
			.ALUResult(DataAdr),
			.WriteData(WriteData)
			);

	imem imem(
			.a(PC),
			.rd(Instr)
			);

	dmem dmem(
			.clk(clk),
			.we(MemWrite),
			.a(DataAdr),
			.wd(WriteData),
			.rd(ReadData)
		);
endmodule
			
