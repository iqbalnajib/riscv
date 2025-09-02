//`include "reset_ff.sv"
//`include "adder.sv"
//`include "mux21.sv"
//`include "mux31.sv"
//`include "regfile.sv"
//`include "extendbit.sv"
//`include "alu.sv"

module datapath(
		input logic clk,
		input logic reset, 
		input logic [1:0] ResultSrc,
		input logic PCSrc,
		input logic ALUSrc,
		input logic RegWrite,
		input logic [1:0] ImmSrc,
		input logic [2:0] ALUControl, 
		input logic [31:0] Instr,
		input logic [31:0] ReadData,
		output logic Zero,
		output logic [31:0] PC,
		output logic [31:0] ALUResult,
		output logic [31:0] WriteData
		);

	logic [31:0] PCNext; 
	logic [31:0] PCPlus4; 
	logic [31:0] PCTarget;
	logic [31:0] ImmExt;
	logic [31:0] SrcA; 
	logic [31:0] SrcB;
	logic [31:0] Result;

	// NSL for PC
	reset_ff #(.WIDTH(32)) pcreg(
			.clk(clk), 
			.reset(reset), 
			.d(PCNext), // Propagate data once 1 clock rising edge (single cycle risc5) (The only sequential block in the circuit)
			.q(PC)
			);

	adder pcadd4(
			.a(PC), 
			.b(32'd4), 
			.y(PCPlus4) // Offset PC by 4 after read the current assembly command line
			);

	adder pcaddbranch(
			.a(PC), 
			.b(ImmExt), // Immediate defines the offset to branched command. 
			.y(PCTarget) // Branch program counter to certain address (if branching occurs)
			);

	mux21 #(.WIDTH(32)) pcmux(
			.d0(PCPlus4), 
			.d1(PCTarget), 
			.sel(PCSrc), // Selects whether the next instruction to be read by PC is offset by 4 only or the branched line.
			.y(PCNext)
			);

	// Register File Logic
	regfile rf(
			.clk(clk), 
			.we3(RegWrite), 
			.a1(Instr[19:15]), // Points Source Register rs1
			.a2(Instr[24:20]), // Points Source Register rs2
			.a3(Instr[11:7]),  // Destination Register rd
			.wd3(Result), // Data thats written in regfile
			.rd1(SrcA),   // Data from source register, rs1
			.rd2(WriteData) //  Data from source register, rs2 (For operation or for sw command - to write in data memory)
			);

	extend ext(
			.instr(Instr[31:7]), // Immediate from instruction (Not include operand)
			.immsrc(ImmSrc), // Choose type of command - I, S, B, J-Type
			.immext(ImmExt) // Extend immediate bits based on command type (From 12 to 32bits)
			);

	// ALU Logic
	mux21 #(.WIDTH(32)) srcbmux(
			.d0(WriteData), // Used in R-type command 
			.d1(ImmExt), 	// Used in I-type command
			.sel(ALUSrc), // Selector
			.y(SrcB) 		// Input SrcB to ALU ( SRC stands for Source )
			);
	
	alu alu(
		.a(SrcA), 
		.b(SrcB),
		.alucontrol(ALUControl), // Select ALU operation
		.zero(Zero), // Compute Zero flag
		.y(ALUResult) // Points to memory address (Want to read or write)
		);

	mux31 #(.WIDTH(32)) resultmux( // Mux that select data to be written(Load) to register
			.d0(ALUResult), 
			.d1(ReadData), 
			.d2(PCPlus4), 
			.sel(ResultSrc),  
			.y(Result)
			);

endmodule
	


