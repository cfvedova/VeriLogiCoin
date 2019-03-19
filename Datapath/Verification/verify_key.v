`include "../../Hash/pearson_hash8.v"
//Needs to be tested

module verify_key(public_key, input_key, random_table, clock, correct);
	input [10:0] public_key;
	input [7:0] input_key;
	input [257:0] random_table;
	input clock;
	
	output reg correct;
	
	reg resetn;
	wire input_public_key;
	wire [2:0] counter;
	
	pearson_hash8 ph(.message(input_key), .reset_n(resetn), .random_table(random_table), .hash(input_public_key), .counter(counter));
	
	always @(clock)
	begin
		case (public_key[10:8])
			3'b010: begin
				resetn <= 1'b1;
				if (counter == 3'b111)
					correct <= public_key[7:0] == input_public_key;
			end
			default: begin
				resetn <= 1'b0;
				correct <= 1'b0;
			end
		endcase
	end
endmodule