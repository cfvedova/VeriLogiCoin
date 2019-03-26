`include "../../Hash/pearson_hash8.v"

module verify_key(public_key, input_key, random_table, clock, correct);
	input [7:0] public_key;
	input [7:0] input_key;
	input [287:0] random_table;
	input clock;
	
	output reg correct;
	
	reg resetn;
	wire [7:0] input_public_key;
	wire [2:0] counter;
	
	pearson_hash8 ph(.clock(clock), .message(input_key), .reset_n(resetn), .random_table(random_table), .hash(input_public_key), .counter(counter));
	
	always @(*)
	begin
		case (public_key)
			8'b0: begin
				correct <= 1'b0;
				resetn <= 1'b0;
			end
			default: begin
				resetn <= 1'b1;
				if (counter == 3'b111)
					correct <= public_key == input_public_key;
			end
		endcase
	end
endmodule