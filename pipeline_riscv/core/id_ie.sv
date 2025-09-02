`include "flopr.sv"
module id_ie(
		input logic clk, reset,
		input logic [31:0] rd1D, 
		input logic [31:0] rd2D, 
		input logic [31:0] pcD,
		input logic [4:0] rdD,
		input logic [31:0] immextD,
		input logic [31:0] pcplus4D,
		output logic [31:0] rd1E, 
		output logic [31:0] rd2E, 
		output logic [31:0] pcE,
		output logic [4:0] rdE,
		output logic [31:0] immextE,
		output logic [31:0] pcplus4E
		);

	flopr #(.WIDTH(32)) rd1DE(
		.clk(clk),
		.reset(reset),
		.d(rd1D),
		.q(rd1E));

	flopr #(.WIDTH(32)) rd2DE(
		.clk(clk),
		.reset(reset),
		.d(rd2D),
		.q(rd2E));

	flopr #(.WIDTH(32)) pcDE(
		.clk(clk),
		.reset(reset),
		.d(pcD),
		.q(pcE));

	flopr #(.WIDTH(5)) rdDE(
		.clk(clk),
		.reset(reset),
		.d(rdD),
		.q(rdE));

	flopr #(.WIDTH(32)) immextDE(
		.clk(clk),
		.reset(reset),
		.d(immextD),
		.q(immextE));

	flopr #(.WIDTH(32)) pcplus4DE(
		.clk(clk),
		.reset(reset),
		.d(pcplus4D),
		.q(pcplus4E));

endmodule
