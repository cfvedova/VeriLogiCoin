`include "../Hash/pearson_hash8.v"

module make_starting_memory(random_table, starting_memory);
	input [287:0] random_table;
	
	output [47:0] starting_memory;
	
	wire [7:0] p1_money = 8'b00110010;
	wire [7:0] p2_money = 8'b00110010;
	wire [7:0] p1_private = 8'b01110101;
	wire [7:0] p2_private = 8'b00011011;
	wire [7:0] p1_public;
	wire [7:0] p2_public;
	wire [2:0] counter1;
	wire [2:0] counter2;
	
	pearson_hash8 ph(.message(p1_private), .reset_n(resetn), .random_table(random_table), .hash(p1_public), .counter(counter1));
	
	pearson_hash8 ph(.message(p2_private), .reset_n(resetn), .random_table(random_table), .hash(p2_public), .counter(counter2));
	
	assign starting_memory = {p1_private, p1_public, p1_money, p2_private, p2_public, p2_money};
	
endmodule