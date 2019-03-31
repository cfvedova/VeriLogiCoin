`include "../../Hash/pearson_hash8.v"

module verify_key(resetn, public_key, input_key, random_table, clock, correct, process);
	input [7:0] public_key;
	input [7:0] input_key;
	input [287:0] random_table;
	input clock, resetn;
	input [2:0] process;
	
	output reg correct;
	wire [7:0] input_public_key;
	wire finished;
	wire enable;
	assign enable = reg_enable;
	reg reg_enable;
	
	pearson_hash8 ph(.clock(clock), .message(input_key), .reset_n(resetn), .random_table(random_table), .hash(input_public_key), .finished(finished), .enable(enable));
	
	always @(posedge clock)
	begin
		if (!resetn) begin
			correct <= 1'b0;
			reg_enable <= 1'b0;
		end
		else if (finished == 1'b1) begin
			correct <= (public_key == input_public_key);		
		end
		if (process == 3'b010) begin
			reg_enable <= 1'b1;
		end
	end
endmodule