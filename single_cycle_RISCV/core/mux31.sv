module mux31 #(parameter WIDTH = 8)(
		input logic [WIDTH-1:0] d0, // 00
		input logic [WIDTH-1:0] d1, // 01
		input logic [WIDTH-1:0] d2, // 10
		input logic [1:0] sel, // 2 bit for 0, 1, 2
		output logic [WIDTH-1:0] y
		);

	assign y = sel[1]? d2 : (sel[0]? d1 : d0);
endmodule
