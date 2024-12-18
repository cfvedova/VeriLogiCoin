module make_starting_memory(clock, resetn, random_table, init_memory, starting_memory);
	input [287:0] random_table;
	input resetn, clock, init_memory;
	output [47:0] starting_memory;
	
	wire [7:0] p1_money = 8'b01100100;
	wire [7:0] p2_money = 8'b01100100;
	wire [7:0] p1_private = 8'b01110101;
	wire [7:0] p2_private = 8'b00011011;
	wire [7:0] p1_public;
	wire [7:0] p2_public;
	wire finished1, finished2;
	
	pearson_hash8 ph1(.clock(clock), .message(p1_private), .reset_n(resetn), .random_table(random_table), .hash(p1_public), .finished(finished1), .enable(init_memory));
	
	pearson_hash8 ph2(.clock(clock), .message(p2_private), .reset_n(resetn), .random_table(random_table), .hash(p2_public), .finished(finished2), .enable(init_memory));
	
	assign starting_memory = {p1_private, p1_public, p1_money, p2_private, p2_public, p2_money};
	
endmodule