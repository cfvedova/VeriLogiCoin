`include "Verification/verify_amount.v"
`include "Verification/verify_key.v"
`include "Verification/complete_transaction.v"

module datapath(process, clock, random_table, memory_values, player_in, input_amount, input_key, load_amount, load_key, load_player, load_register, resetn, done_step, result_out);
	input [287:0] random_table;
	input [47:0] memory_values;
	input clock, load_amount, load_key, load_player, load_register, resetn;
	input [2:0] process;
	input [7:0] input_amount, input_key;
	input player_in;
	
	output reg done_step;
	output [47:0] result_out;
	
	wire verify_amount_signal, verify_key_signal;
	
	reg [7:0] amount;
	reg [7:0] key;
	reg [7:0] p1_private_key;
	reg [7:0] p2_private_key;
	reg [7:0] p1_public_key;
	reg [7:0] p2_public_key;
	reg [7:0] p1_amount;
	reg [7:0] p2_amount;
	reg player;
	
	//Input Amount Register
	always @(posedge clock)
	begin
		if(resetn == 1'b0)
			amount <= 8'b00000000;
		else if(load_amount)
			amount <= input_amount;
	end
	
	//Input Key Register
	always @(posedge clock)
	begin
		if(resetn == 1'b0)
			key <= 8'b00000000;
		else if(load_key)
			key <= input_key;
	end
	
	//Player Choice
	always @(posedge clock)
	begin
		if (resetn == 1'b0)
			player <= 1'b0;
		else if (load_player)
			player <= player_in;
	end
	
	//P1 Private Key
	always @(posedge clock)
	begin
		if (resetn == 1'b0) begin
			p1_private_key <= 8'b0;
			p2_private_key <= 8'b0;
			p1_public_key <= 8'b0;
			p2_public_key <= 8'b0;
			p1_amount <= 8'b0;
			p2_amount <= 8'b0;
		end
		else if (load_register) begin
			p1_private_key <= memory_values[47:40];
			p2_private_key <= memory_values[23:16];
			p1_public_key <= memory_values[39:32];
			p2_public_key <= memory_values[15:8];
			p1_amount <= memory_values[31:24];
			p2_amount <= memory_values[7:0];
		end
	end
	
	wire [7:0] player_amount = (player) ? p2_amount: p1_amount;
	verify_amount va(.amount(amount), .player_money(player_amount), .clock(clock), .correct(verify_amount_signal));
	
	wire [7:0] real_public_key = (player) ? p2_public_key : p1_public_key;
	verify_key vk(.process(process), .resetn(resetn), .public_key(real_public_key), .input_key(key), .random_table(random_table), .clock(clock), .correct(verify_key_signal));
	
	wire [7:0] p1_amount_out, p2_amount_out;
	complete_transaction ct(.p1_amount(p1_amount), .p2_amount(p2_amount), .amount_change(amount), .person(player), .clock(clock), .p1_amount_out(p1_amount_out), .p2_amount_out(p2_amount_out));
	
	always @(posedge clock)
	begin
		case (process)
			3'b001: done_step <= verify_amount_signal;
			3'b010: done_step <= verify_key_signal; //Will be zero until the hash is complete
			default: done_step <= 1'b0;
		endcase
	end
	
	assign result_out = {p1_private_key, p1_public_key, p1_amount_out, p2_private_key, p2_public_key, p2_amount_out};
endmodule