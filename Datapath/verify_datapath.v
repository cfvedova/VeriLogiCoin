`include "Verification/verify_amount.v"
`include "Verification/verify_key.v"

module verify_datapath(clock, random_table, memory_out, input_amount, input_key, load_amount, load_key, resetn, done_step);
	input [257:0] random_table;
	input [10:0] memory_out;
	input clock, load_amount, load_key, resetn;
	input [2:0] process;
	input [7:0] input_amount, input_key;

	output reg done_step;
	
	wire verify_amount, verify_key;
	
	reg [7:0] amount;
	reg [7:0] key;
	
	//Amount Register
	always @(*)
	begin
		if(resetn == 1'b0)
			amount <= 8'b00000000;
		else if(load_amount)
			amount <= input_amount;
	end
	
	//Key Register
	always @(*)
	begin
		if(resetn == 1'b0)
			key <= 8'b00000000;
		else if(load_key)
			key <= input_key;
	end
	
	verify_amount va(.amount(amount), .player_money(memory_out), .clock(clock), .correct(verify_amount));
	
	verify_key vk(.public_key(memory_out), .input_key(key), .random_table(random_table), .clock(clock), .correct(verify_key));
	
	always @(clock)
	begin
		case (memory_out[10:8])
			3'b001: done_step <= verify_amount;
			3'b010: done_step <= verify_key;
			default: done_step <= 1'b0;
	end
endmodule;