module maindec( // This is extended single cycle processor coding
		input logic [6:0] op, // 7 bit operand (determines operation)
		output logic RegWrite,
		output logic [1:0] ImmSrc,
		output logic ALUSrc,
		output logic MemWrite,
		output logic [1:0] ResultSrc,
		output logic Branch,
		output logic [1:0] ALUOp,
		output logic Jump
		);

	logic [10:0] controls;

	// Append (11 bits) to controls (easier to control/read signal)
	assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;

	always_comb // Check operands in assembly cheatsheet.
	begin	case(op) // This design is only for these basic commands.
	//                   RegWrite_ImmSrc[1:0]_ALUSrc_MemWrite_ResultSrc[1:0]_Branch_AluOp[1:0]_Jump
	7'b0000011: controls = 11'b1_____00_________1_______0__________01__________0_________00______0; // lw command 
                  
	7'b0100011: controls = 11'b0_____01_________1_______1__________00__________0_________00______0; // sw command

	// For beq, no comparator used, instead use ALU sub. if Zero = 1, Branch. 
	7'b1100011: controls = 11'b0_____10_________0_______0__________00__________1_________01______0; // beq command

	7'b1101111: controls = 11'b1_____11_________0_______0__________10__________0_________00______1; // jal command
                                  // ImmSrc (Imm not used in R-type commands)
	7'b0110011: controls = 11'b1_____xx_________0_______0__________00__________0_________10______0; // R-type command

	7'b0010011: controls = 11'b1_____00_________1_______0__________00__________0_________10______0; // I-Type ALU command

	default: controls = 11'bx_xx_x_x_xx_x_xx_x;
	endcase end

endmodule

// Functions of these signals
// RegWrite connect to Regfile(DP), enables write operation on registers

// [1:0] ImmSrc connect to Extend(DP), enables immediate extension - To determine type of command (I, R,S, B, J type) and extend immediate bits appropriately.

// ALUSrc connect to srcBmux. Use to select 0 or 1(ImmExt) to be input B of ALU

// MemWrite connect to DataMemory. Use to enable/disable write memory. (Write in memory address)

// [1:0] ResultSrc connect to resultmux. Use to select 0 or 1 to mux output to Regfile Write input (data that overwrites the destination register)

// [1:0] ALUOp controls the operation of addition/subtraction

// Branch and Jump - Both used to obtain signal PCSrc (Connect to PCnext mux) - Select PCPlus4 or PCTarget.
// In CU file
