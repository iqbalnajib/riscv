// Resettable flip flop

module reset_ff #(parameter WIDTH = 8)( // Parameterized
		input logic clk,
		input logic reset,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q
		);

	always_ff@(posedge clk, negedge reset)
	begin 
		if (reset == 0) q <= 0;
		else q <= d;
	end

endmodule

