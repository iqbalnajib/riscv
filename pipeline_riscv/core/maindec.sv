module maindec(
		input  logic [6:0] op,
		input  logic zero,
		output logic [1:0] result_src,
		output logic mem_write,
		output logic alu_src,
		output logic reg_write,
		output logic [1:0] imm_src,
		output logic [1:0] alu_op,
		output logic [1:0] pcsrc
	);

	always_comb begin
		case(op)
			7'b0000011: begin // I-type, lw
				reg_write = 1'b1;
				imm_src = 2'b0;
				alu_src = 1'b1;
				mem_write = 1'b0;
				result_src = 2'b01;
				alu_op = 2'b0;
				pcsrc = 2'b00;
			end
			7'b1100111: begin // I-type, jalr
				reg_write = 1'b1;
				imm_src = 2'b0;
				alu_src = 1'b1;
				mem_write = 1'b0;
				result_src = 2'b00;
				alu_op = 2'b0;
				pcsrc = 2'b10;
			end
			7'b0100011: begin // S-type, sw
				reg_write = 1'b0;
				imm_src = 2'b01;
				alu_src = 1'b1;
				mem_write = 1'b1;
				result_src = 2'b00;
				alu_op = 2'b00;
				pcsrc = 2'b00;
			end
			7'b0110011: begin // R-type
				reg_write = 1'b1;
				imm_src = 2'bxx;
				alu_src = 1'b0;
				mem_write = 1'b0;
				result_src = 2'b00;
				alu_op = 2'b10;
				pcsrc = 2'b00;
			end
			7'b1100011: begin // beq
				reg_write = 1'b0;
				imm_src = 2'b10;
				alu_src = 1'b0;
				mem_write = 1'b0;
				result_src = 2'b00;
				pcsrc = zero ? 2'b01 : 2'b00;
				alu_op = 2'b01;
			end
			7'b0010011: begin // I-type ALU
				reg_write = 1'b1;
				imm_src = 2'b00;
				alu_src = 1'b1;
				mem_write = 1'b0;
				result_src = 2'b00;
				alu_op = 2'b10;
				pcsrc = 2'b00;
			end
			7'b1101111: begin // J-type
				reg_write = 1'b1;
				imm_src = 2'b11;
				alu_src = 1'b0;
				mem_write = 1'b0;
				result_src = 2'b10;
				alu_op = 2'b00;
				pcsrc = 2'b01;
			end

			default: begin
				reg_write = 1'bx;
				imm_src = 2'bx;
				alu_src = 1'bx;
				mem_write = 1'bx;
				result_src = 2'bxx;
				alu_op = 2'bx0;
				pcsrc = 2'bxx;
			end
		endcase
	end
endmodule
