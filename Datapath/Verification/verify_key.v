`include "../../Hash/pearson_hash8.v"

module verify_key(public_key, input_key, random_table, clock, correct);
	input [7:0] public_key;
	input [7:0] input_key;
	input [287:0] random_table;
	input clock;
	
	output reg correct;
	
	reg resetn;
	wire [7:0] input_public_key;
	wire finished;
	
	pearson_hash8 ph(.clock(clock), .message(input_key), .reset_n(resetn), .random_table(random_table), .hash(input_public_key), .finished(finished));
	
	always @(posedge clock)
	begin
		case (public_key)
			8'b0: begin
				correct <= 1'b0;
				resetn <= 1'b0;
			end
			default: begin
				resetn <= 1'b1;
				if (finished == 1'b1)
					correct <= public_key == input_public_key;
			end
		endcase
	end
endmodule