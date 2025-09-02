module aludec(
		input logic opb5, // bit 5 of operand
		input logic [2:0] funct3, // funct3 based on command
		input logic funct7b5, // bit 5 of func 7
		input logic [1:0] ALUOp, // Input from maindec
		output logic [2:0] ALUControl // ALU operation selector
		);

	logic RtypeSub; // R type (Usually to indicate beq - comparing 2 reg values) 
	assign RtypeSub = funct7b5 & opb5; // funct7[5] = 1, op[5] = 1 (Basically sub operation) Can refer to RISC-V Ref Card

	always_comb begin
	case(ALUOp) // ALUOp determines if beq occurs
2'b00: ALUControl = 3'b000; // Addition only
2'b01: ALUControl = 3'b001; // beq Subtraction (Compare)
default: case(funct3)
// Add and Sub both func3 = 3'b000. If Rtype-Sub=1, means compare or subtraction occurs (to generate Zero flag)
		3'b000: if (RtypeSub) ALUControl = 3'b001; // No immediate subtraction. 
				else ALUControl = 3'b000;
		3'b010: ALUControl = 3'b101; // slt
		3'b110: ALUControl = 3'b011; // or
		3'b111: ALUControl = 3'b010; // and
		default: ALUControl = 3'bxxx; // no operation
		endcase
	endcase
end

endmodule

		

