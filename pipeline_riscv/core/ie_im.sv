`include "flopr.sv"

module ie_im(
		input logic clk, reset,
		input logic [31:0] aluresultE, 
		input logic [31:0] writedataE, 
		input logic [4:0] rdE,
		input logic [31:0] pcplus4E,
		output logic [31:0] aluresultM, 
		output logic [31:0] writedataM, 
		output logic [4:0] rdM,
		output logic [31:0] pcplus4M
		);

	flopr #(.WIDTH(32)) aluresultEM(
		.clk(clk),
		.reset(reset),
		.d(aluresultE),
		.q(aluresultM));

	flopr #(.WIDTH(32)) writedataEM(
		.clk(clk),
		.reset(reset),
		.d(writedataE),
		.q(writedataM));

	flopr #(.WIDTH(5)) rdEM(
		.clk(clk),
		.reset(reset),
		.d(rdE),
		.q(rdM));

	flopr #(.WIDTH(32)) pcplus4EM(
		.clk(clk),
		.reset(reset),
		.d(pcplus4E),
		.q(pcplus4M));

endmodule
