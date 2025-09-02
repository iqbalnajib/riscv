module extend(
		input logic [31:7] instr,	// Instruction command (32bits)
		input logic [1:0] immsrc,	// Src determines the type of command (op)
		output logic [31:0] immext 	// Sign extended output
		); 

// Instruction (command) is 32bits 
// Type of operand is 2 bits (immsrc) - Determine I, S, B or J type command
// rs1 is source register 
// rd is destination register

// Consider the command consist of:

// I-type (Immediate)
// imm11:0_rs1_func3_rd_op
//    (12)       (5)  (3)  (5)    (7)         
// xxxxxxxxxxxx_xxxxx_xxx_xxxxx_xxxxxxx
// Sign extend , append with imm11:0 from 31:20

// S-type
// imm11:5_rs2_rs1_func3_imm4:0_op
//   (7)    (5)   (5)  (3)   (5)    (7)
// xxxxxxx_xxxxx_xxxxx_xxx__xxxxx_xxxxxxx
// Sign extend, append with imm11:5, imm4:0 from 31:25 and 11:7

// B-type
// imm12_imm10:5_rs2_rs1_func3_imm4:1_imm11_op
//(1) (6)   (5)   (5)  (3) (4) (1)   (7)
// x_xxxxxx_xxxxx_xxxxx_xxx_xxxx_x_xxxxxxx
// Sign extend, append with imm12,10:5 and imm4:1,11 from 31:25 and 11:7 

// J-type
// imm20_imm10:1_imm11_imm19:12_rd_op
//(1)    (10)  (1)   (8)    (5)    (7)
// x_xxxxxxxxxx_x_xxxxxxxx_xxxxx_xxxxxxx
// Sign extend, append with imm20, imm10:1, imm11, imm19:12

// We take the immediate values only from the command (Append)
// The immediate values are arranged in a way that is reduced (Sequence dari 31 to 0 ) - Refer to Page 41 of Chapter 7
always_comb
begin 
	case(immsrc) // Tells the extend block what type of command it is.
		// I-type (Load) (Sign extend the 20 MSB, the Lower 12bits appended by bit 20-31 of instr            Extend           imm11:0
	2'b00: immext = {{20{instr[31]}}, instr[31:20]}; 

	// S-type (Store) Extend         imm11:5        imm4:0 
	2'b01: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // Imm taken from 32bit instruction 

	// B-type (Branch) Extend         imm12     imm11      imm10:5       imm4:1     Last Bit always 0 to configure word-alligned (offset by 2 - 10)
	2'b10: immext = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

	// J-type (Jump) Extend           imm20      imm19:12     imm11       imm10:1
	2'b11: immext = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

	default: immext = 32'bx; 
	endcase
end

endmodule
// Dua bit hujung xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxx0 - Last bit doesnt matter because PC offset by 4 every time (100) So the last bit is always zero
// 4 - 100
// 8 - 1000
// c - 1100

