`include "adder.sv"
`include "mux2.sv"
`include "mux3.sv"
`include "flopr.sv"
`include "extend.sv"
`include "regfile.sv"
`include "alu.sv"
`include "if_id.sv"
`include "id_ie.sv"
`include "ie_im.sv"
`include "im_iw.sv"

module datapath (
		input logic clk, reset,
		input logic reg_write,
		input logic [1:0] imm_src,
		input logic alu_src,
		input logic [1:0] result_src,
		input logic [2:0] alu_control,
		input logic [1:0] pcsrc,
		input logic [31:0] instrF,
		input logic [31:0] readdataM,
		output logic [31:0] instrD,
		output logic zero,
		output logic [31:0] pcF,
		output logic [31:0] writedataM,
		output logic [31:0] aluresultM
	);

	//logic [31:0] pcplus4F;
	logic [31:0] pctargetE;
	logic [31:0] pcF_next;
	logic [31:0] srcaE, srcbE;
	logic [31:0] pcplus4F;
	//logic [31:0] instrD;
	logic [31:0] rd1D, rd2D, pcD, immextD, pcplus4D;
	logic [31:0] pcE, immextE;
	logic [4:0] rdE, rdM, rdW;
	logic [31:0] aluresultE, pcplus4E, writedataE;  
	logic [31:0] pcplus4M;
	logic [31:0] readdataW, pcplus4W, resultW, aluresultW;
	

	adder pcplus4(
		.a(pcF),
		.b(32'd4),
		.y(pcplus4F));

	adder pcaddbranch(
		.a(pcE),
		.b(immextE),
		.y(pctargetE));

	mux3 #(.WIDTH(32)) pcmux (
		.d0(pcplus4F),
		.d1(pctargetE),
		.d2(resultW),
		.s (pcsrc), //select
		.y (pcF_next));
		
	if_id reg1(
		.clk(clk),
		.reset(reset),
		.instrF(instrF),
		.pcF(pcF),
		.pcplus4F(pcplus4F),
		.instrD(instrD[31:0]),
		.pcD(pcD),
		.pcplus4D(pcplus4D)
		);

	flopr #(.WIDTH(32)) pc_reg(
		.clk(clk),
		.reset(reset),
		.d(pcF_next),
		.q(pcF));

	extend imm_extend(
		.instr(instrD[31:7]),
		.imm_src(imm_src),
		.immext(immextD));

	regfile rf(
		.clk(clk),
		.we3(reg_write),
		.a1(instrD[19:15]),
		.a2(instrD[24:20]),
		.a3(rdW),
		.wd3(resultW),
		.rd1(rd1D),
		.rd2(rd2D));
	
	id_ie reg2(
		.clk(clk),
		.reset(reset),
		.rd1D(rd1D),
		.rd2D(rd2D),
		.pcD(pcD),
		.rdD(instrD[11:7]),
		.immextD(immextD),
		.pcplus4D(pcplus4D),
		.rd1E(srcaE),
		.rd2E(writedataE),
		.pcE(pcE),
		.rdE(rdE),
		.immextE(immextE),
		.pcplus4E(pcplus4E)
		);

	mux2 #(.WIDTH(32)) srcb_mux(
		.d0(writedataE),
		.d1(immextE),
		.s (alu_src),
		.y (srcbE));

	alu u_alu(
		.a(srcaE),
		.b(srcbE),
		.alu_control(alu_control),
		.zero(zero),
		.result(aluresultE));
	
	ie_im reg3(
		.clk(clk),
		.reset(reset),
		.aluresultE(aluresultE),
		.writedataE(writedataE),
		.rdE(rdE),
		.pcplus4E(pcplus4E),
		.aluresultM(aluresultM),
		.writedataM(writedataM),
		.rdM(rdM),
		.pcplus4M(pcplus4M)
		);

	mux3 #(.WIDTH(32)) result_mux(
		.d0(aluresultW),
		.d1(readdataW),
		.d2(pcplus4W),
		.s (result_src),
		.y (resultW));
	
	im_iw reg4(
		.clk(clk),
		.reset(reset),
		.aluresultM(aluresultM),
		.readdataM(readdataM),
		.rdM(rdM),
		.pcplus4M(pcplus4M),
		.aluresultW(aluresultW),
		.readdataW(readdataW),
		.rdW(rdW),
		.pcplus4W(pcplus4W)
		);
endmodule