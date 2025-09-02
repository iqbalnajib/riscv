module alu(
	input logic [31:0] a,
	input logic [31:0] b,
	input logic [2:0] alucontrol,
	output logic zero,
	output logic [31:0] y
	);
	
	logic [31:0] invb, sum;
	logic overflow;
	logic is_addsub;

	always_comb
	begin case(alucontrol)
	3'b000: y = a + b;
	3'b001: y = a + (~b + alucontrol[0]); // two's complement of b
	3'b010: y = a & b;
	3'b011: y = a | b;
	3'b101: y = {31'b0, sum[31] ^ overflow}; // (a < b)? 32'b1 : 32'b0; // Set(TRUE) if a Less than b. Else reset
	default: y = 32'bx;
	endcase end

	assign is_addsub = (alucontrol == 0) || (alucontrol == 1) || (alucontrol == 3'b101);
	assign invb = alucontrol[0]? ~b : b;
	assign sum = a + invb + alucontrol[0];
	assign overflow = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & is_addsub;
	
	assign zero = (y !== 0)? 0 : 1;
endmodule

// For Signed ALU, no Overflow errors
//	module alu_signed(
//	input logic signed [31:0] a, b,
//	input logic [2:0] alucontrol,
//	output logic [31:0] y
//	);
//	
//	always_comb
//		case(alucontrol)
//			3'b000: y = a + b;
//			3'b001: y = a - b;
//			3'b010: y = a & b;
//			3'b011: y = a | b;
//			3'b100: y = a ^ b;
//			3'b101: y = a < b; // slt
//			3'b110: y = a << b[4:0]; // sll
//			3'b111: y = a >> b[4:0]; // srl
//			default: y = 32'bx;
//		endcase
//	endmodule
