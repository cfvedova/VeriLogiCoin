`include "Verification/verify_amount.v"
`include "Verification/verify_key.v"
`include "Verification/complete_transaction.v"

module datapath(process, clock, random_table, memory_out, input_amount, input_key, load_amount, load_key, resetn, done_step, p1_amount_out, p2_amount_out);
	input [257:0] random_table;
	input [10:0] memory_out;
	input clock, load_amount, load_key, resetn;
	input [2:0] process;
	input [7:0] input_amount, input_key;
	
	output [10:0] p1_amount_out, p2_amount_out;
	output reg done_step;
	
	wire verify_amount_signal, verify_key_signal, complete_transaction_signal;
	
	reg [7:0] amount;
	reg [7:0] key;
	reg [7:0] p1_amount;
	reg [7:0] p2_amount;
	reg [7:0] real_public_key;
	reg player;
	
	//Input Amount Register
	always @(*)
	begin
		if(resetn == 1'b0)
			amount <= 8'b00000000;
		else if(load_amount)
			amount <= input_amount;
	end
	
	//Input Key Register
	always @(*)
	begin
		if(resetn == 1'b0)
			key <= 8'b00000000;
		else if(load_key)
			key <= input_key;
	end
	
	//Real Public Key
	always @(*)
	begin
		if(resetn == 1'b0)
			real_public_key <= 8'b0;
		else if (load_public_key)
			real_public_key <= memory_out;
	end
	
	//Player Money
	always @(*)
	begin
		if (resetn == 1'b0)
			p1_amount <= 8'b0;
		else if (load_p1_amount)
			p1_amount <= memory_out;
	end
	
	always @(*)
	begin
		if (resetn == 1'b0)
			p2_amount <= 8'b0;
		else if (load_p2_amount)
			p2_amount <= memory_out;
	end
	
	//Player Choice
	always @(*)
	begin
		if (resetn == 1'b0)
			player <= 1'b0;
		else if (load_player)
			player <= player_in;
	end
	
	wire player_amount = (player) ? p2_amount: p1_amount;
	verify_amount va(.amount(amount), .player_money(player_amount), .clock(clock), .correct(verify_amount_signal));
	
	verify_key vk(.public_key(real_public_key), .input_key(key), .random_table(random_table), .clock(clock), .correct(verify_key_signal));
	
	complete_transaction ct(.process(), .p1_amount(p1_amount), .p2_amount(p2_amount), .amount_change(amount), .clock(clock), .p1_amount_out(p1_amount_out), .p2_amount_out(p2_amount_out), .complete_transaction_signal(complete_transaction_signal));
	
	always @(clock)
	begin
		case (memory_out[10:8])
			3'b001: done_step <= verify_amount_signal;
			3'b010: done_step <= verify_key_signal;
			3'b100: done_step <= complete_transaction_signal;
			default: done_step <= 1'b0;
		endcase
	end
endmodule