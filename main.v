//Main will connect the keyboard to the actual program

`include "Controllers/main_control.v"
`include "Controllers/transaction_control.v"
`include "Controllers/memory_control.v"
`include "Datapath/datapath.v"
`include "Memory/RAM/blockchain_ram_entry.v"
`include "Memory/data_registers.v"
`include "Memory/make_starting_memory.v"
`include "Visuals/money_display.v"
`include "Hash/lfsr.v"

//`default_nettype none
module main(SW, KEY, CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, VGA_CLK, VGA_HS, VGA_VS,	VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	//VGA output for display. Do not change
	output VGA_CLK;   				//	VGA Clock
	output VGA_HS;					//	VGA H_SYNC
	output VGA_VS;					//	VGA V_SYNC
	output VGA_BLANK_N;				//	VGA BLANK
	output VGA_SYNC_N;				//	VGA SYNC
	output [9:0] VGA_R;   				//	VGA Red[9:0]
	output [9:0] VGA_G;	 				//	VGA Green[9:0]
	output [9:0] VGA_B;   				//	VGA Blue[9:0]
	
	//Wires for main_control
	wire load_player;
	wire load_amount;
	wire load_key;
	wire load_memory;
	wire init_memory;
	wire finished_init;
	wire random_init;
	wire done_creating_sequence;
	wire global_reset;
	wire reset_screen;
	wire done_plotting;
	
	//Connections between controls
	wire start_transaction;
	wire reset_others;
	
	//Wires for transaction_control
	reg done_process;
	wire done_travel = 1'b1;
	wire [2:0] process;
	wire [2:0] travel;
	
	//Wires for Memory Control
	wire load_registers; //Loads registers in datapath
	wire wren_registers;
	wire access_type;
	wire done_memory_store;
	wire done_hash_store;
	wire load_previous_hash;
	wire enable_mining;
	wire done_mining;
	wire [7:0] new_hash;
	wire [47:0] data_in;
	wire [47:0] starting_memory;
	
	//Wires for Datapath
	wire [47:0] result_out;
	wire done_data_process;
	
	//Wires for Hash
	wire [287:0] random_table;
	
	//Wires for Memory
	wire [47:0] memory_values;
	wire [63:0] new_block;
	wire [63:0] output_block;

	wire overall_reset = reset_others && global_reset;
	//Init random table
	lfsr lfsr(.random_sequence(random_table), .clk(CLOCK_50), .reset(global_reset), .done_creating_sequence(done_creating_sequence), .enable(random_init));
	
	//INIT Memory
	make_starting_memory starting_mem(.clock(CLOCK_50), .resetn(global_reset), .random_table(random_table), .init_memory(init_memory), .starting_memory(starting_memory));
	
	wire wren_blockchain = access_type && wren_registers; //Only write the block if the registers are wri
	//Blockchain Storage
	blockchain blkchain(.currently_hashing(enable_mining), .wren(wren_blockchain), .message(new_block), .clock(CLOCK_50), .resetn(KEY[2]), .output_message(output_block));
	
	//Data Registers
	data_registers data_register1(.clock(CLOCK_50), .access_type(access_type), .data_in(data_in), .wren(wren_registers), .result(memory_values), .resetn(global_reset));
	
	//Memory Controller
	memory_control mem_control(.clock(CLOCK_50), .global_reset(global_reset), .resetn(overall_reset), .load_memory(load_memory), .init_memory(init_memory), .done_mining(done_mining), .process(process),
							   .datapath_out(result_out), .starting_memory(starting_memory), .mining_hash(new_hash), .write_enable(wren_registers), .access_type(access_type),
							   .data_in(data_in), .load_registers(load_registers), .enable_mining(enable_mining), .done_hash_store(done_hash_store), .done_memory_store(done_memory_store), .finished_init(finished_init), .load_previous_hash(load_previous_hash));
	
	//Main Controller
	main_control main_control(.start_signal(~KEY[0]), .load_signal(~KEY[1]), .finished_init(finished_init), .finished_transaction(done_memory_store), .done_plotting(done_plotting),
							  .resetn(KEY[2]), .reset_transaction(KEY[3]), .clock(CLOCK_50), .done_table_init(done_creating_sequence), .reset_others(reset_others), .init_memory(init_memory), .load_player(load_player),
							  .load_amount(load_amount), .load_key(load_key), .load_memory(load_memory), .start_transaction(start_transaction), .random_init(random_init), .global_reset(global_reset), .reset_screen(reset_screen), .states(HEX0));
	
	//Main Controller for Transaction
	transaction_control transac_control(.start_transaction(start_transaction), .done_step(done_process), .done_travel(done_travel),
										.resetn(overall_reset), .clock(CLOCK_50), .step(process), .travel(travel), .states(HEX1));
	
	//Datapath for verifying Info.
	datapath verdata(.process(process), .clock(CLOCK_50), .random_table(random_table), .memory_values(memory_values), .player_in(SW[0]),
					 .input_amount(SW[7:0]), .input_key(SW[7:0]), .load_amount(load_amount), .load_key(load_key), .load_player(load_player),
					 .load_register(load_registers), .enable_mining(enable_mining), .load_previous_hash(load_previous_hash), .resetn(overall_reset),
					 .done_step(done_data_process), .result_out(result_out), .done_mining(done_mining), .new_hash(new_hash), .final_message(new_block),
					 .correct_sk(LEDR[7:0]), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
	
	assign LEDR[9:8] = 2'b0;
	
	//Money_display
	money_display display(.clock(CLOCK_50), .memory_out(memory_values), .load_memory(load_memory), .resetn(overall_reset), .blackout(reset_screen), .done_plotting(done_plotting),
		.VGA_CLK(VGA_CLK),   						
		.VGA_HS(VGA_HS),							
		.VGA_VS(VGA_VS),							
		.VGA_BLANK_N(VGA_BLANK_N),						
		.VGA_SYNC_N(VGA_SYNC_N),						
		.VGA_R(VGA_R),   						
		.VGA_G(VGA_G),	 						
		.VGA_B(VGA_B)   						
	);
	
	always @(*)
	begin
		case (process)
			3'b001: done_process <= done_data_process;
			3'b010: done_process <= done_data_process; //Will be zero until the hash is complete
			3'b011: done_process <= done_hash_store;
			3'b100: done_process <= done_memory_store;
			default: done_process <= 1'b0;
		endcase
	end
endmodule
