module regfile(
		input logic clk,
		input logic we3, // RegWrite
		input logic [4:0] a1,
		input logic [4:0] a2, // a1 and a2 points the memory address to read from.  
		input logic [4:0] a3, // a3 points the memory address to write
		input logic [31:0] wd3,
		output logic [31:0] rd1,
		output logic [31:0] rd2
		);

	logic [31:0] rf [32]; // Memory Register Size (Register has 32 address and 32 bit word per address)

	initial begin
		rf[4] = 1;
		rf[6] = 32'habcd;
		rf[9] = 32'h10000000;
	end

	always@(posedge clk)
	begin if (we3 == 1) rf[a3] <= wd3; // we3 is WriteEnable
	else rf[a3] <= rf[a3];
	end

// Read data (o/p rd1) in reg rf[a1] with address pointed by a1 
	assign rd1 = (a1 != 0)? rf[a1] : 0; 	

// Same with a2 (o/p rd2)
	assign rd2 = (a2 != 0)? rf[a2] : 0;

endmodule

