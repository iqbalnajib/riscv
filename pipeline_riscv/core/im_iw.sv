`include "flopr.sv"

module im_iw(
		input logic clk, reset,
		input logic [31:0] aluresultM, 
		input logic [31:0] readdataM, 
		input logic [4:0] rdM,
		input logic [31:0] pcplus4M,
		output logic [31:0] aluresultW, 
		output logic [31:0] readdataW, 
		output logic [4:0] rdW,
		output logic [31:0] pcplus4W
		);

	flopr #(.WIDTH(32)) aluresultMW(
		.clk(clk),
		.reset(reset),
		.d(aluresultM),
		.q(aluresultW));

	flopr #(.WIDTH(32)) readdataMW(
		.clk(clk),
		.reset(reset),
		.d(readdataM),
		.q(readdataW));

	flopr #(.WIDTH(5)) rdMW(
		.clk(clk),
		.reset(reset),
		.d(rdM),
		.q(rdW));

	flopr #(.WIDTH(32)) pcplus4MW(
		.clk(clk),
		.reset(reset),
		.d(pcplus4M),
		.q(pcplus4W));

endmodule
