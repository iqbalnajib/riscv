module aludec(
		input  logic [6:0] op,
		input  logic [2:0] func3,
		input  logic func7b5,
		input  logic [1:0] alu_op,
		output logic [2:0] alu_control
	);

	logic rtype_sub;
	assign rtype_sub = func7b5 & op[5];

	always_comb begin
		case(alu_op)
			2'b00: alu_control = 3'b000; // addition
			2'b01: alu_control = 3'b001; // subtraction
			2'b10: case(func3)
					3'b000: begin
						if(rtype_sub) alu_control = 3'b001; // subtraction
						else alu_control = 3'b000; // addition
					end
					3'b010: alu_control = 3'b101; // slt, slti
					3'b110: alu_control = 3'b011; // or, ori
					3'b111: alu_control = 3'b010; // and, andi
				endcase
			default: alu_control = 3'bxxx;
		endcase
	end
endmodule
