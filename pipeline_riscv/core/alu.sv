module alu(
		input logic [31:0] a, b,
		input logic [2:0] alu_control,
		output logic zero,
		output logic [31:0] result);

	logic [31:0] invb, sum;
	logic overflow;
	logic is_addsub;

	assign is_addsub = (alu_control == 3'b000) || (alu_control == 3'b001) || (alu_control == 3'b101);
	assign invb = alu_control[0] ? ~b : b;
	assign sum  = a + invb + alu_control[0];
	assign overflow = ~(alu_control[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & is_addsub;
	assign zero = (result == 32'b0);

	always_comb
		case(alu_control)
			3'b000, 3'b001: result = sum; // sum and subtract
			3'b010: result = a & b; // and
			3'b011: result = a | b; // or
			3'b100: result = a ^ b; // xor
			3'b101: result = {31'b0, sum[31] ^ overflow}; // slt
			3'b110: result = a << b[4:0]; // sll
			3'b111: result = a >> b[4:0]; // srl
			default result = 32'hx;
		endcase

endmodule

// module alu_signed(
// 		input logic signed [31:0] a, b,
// 		input logic [2:0] alu_control,
// 		output logic [31:0] result);

// 	always_comb
// 		case(alu_control)
// 			3'b000: result = a + b; // sum
// 			3'b001: result = a - b; // subtract
// 			3'b010: result = a & b; // and
// 			3'b011: result = a | b; // or
// 			3'b100: result = a ^ b; // xor
// 			3'b101: result = {31'b0, a < b}; // slt
// 			3'b110: result = a << b[4:0]; // sll
// 			3'b111: result = a >> b[4:0]; // srl
// 			default result = 32'hx;
// 		endcase

// endmodule

