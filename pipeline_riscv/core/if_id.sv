`include "flopr.sv"
module if_id(
		input logic clk, reset,
		input logic [31:0] instrF, 
		input logic [31:0] pcF, 
		input logic [31:0] pcplus4F,
		output logic [31:0] instrD,
		output logic [31:0] pcD,
		output logic [31:0] pcplus4D
	);

	flopr #(.WIDTH(32)) instrFD(
		.clk(clk),
		.reset(reset),
		.d(instrF),
		.q(instrD));

	flopr #(.WIDTH(32)) pcFD(
		.clk(clk),
		.reset(reset),
		.d(pcF),
		.q(pcD));

	flopr #(.WIDTH(32)) pcplus4FD(
		.clk(clk),
		.reset(reset),
		.d(pcplus4F),
		.q(pcplus4D));

endmodule
