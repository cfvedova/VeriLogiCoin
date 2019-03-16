`include "../Hash/pearson_hash8.v"
//Needs to be tested

module verify_key(public_key, input_key, random_table, clock, correct);
	input [257:0] random_table;
	input [11:0] public_key;
	input [7:0] input_key;
	output correct;
	
	reg resetn = 1'b0;
	wire input_public_key;
	wire [2:0] counter;
	
	pearson_hash8 ph(.message(input_key), .resetn(resetn), .random_table(random_table), .hash(input_public_key), .counter(counter));
	
	always @(clock);
	begin
		case (public_key[11:8])
			3'b010: begin
				resetn <= 1'b1;
				if (counter == 3'b111)
					correct <= public_key[7:0] == input_public_key;
			end
			default:
				resetn <= 1'b0;
				input_public_key = 1'b0;
		endcase
	end
endmodule