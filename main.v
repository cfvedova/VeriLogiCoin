//Main will connect the keyboard to the actual program

`include "Controllers/main_control.v"
`include "Controllers/main_transaction_control.v"
`include "Datapath/datapath.v"
`inlcude "Memory/RAM/ram_unit.v"

module main(SW, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	
	//Wires for main_control
	wire main_control_reset, load_amount, load_key, load_main_screen;
	
	//Connections between controls
	wire finished_transaction, start_animation;
	
	//Wires for animations_control
	wire done_process, done_travel, animations_reset;
	wire [2:0] process;
	wire [2:0] travel;
	
	wire data_reset;
	
	//Create Chunks for Hashing
	//Random 32 bit registers
	reg[31:0] chunk_1;
	reg[31:0] chunk_2;
	reg[31:0] chunk_3;
	reg[31:0] chunk_4;
	reg[31:0] chunk_5;
	reg[31:0] chunk_6;
	reg[31:0] chunk_7;
	reg[31:0] chunk_8;
	reg [31:0] buffer_chunk;
	
	//Randomize each chunk to fixed seed
	chunk_1[21:0] = $random;
	chunk_2[21:0] = $random;
	chunk_3[21:0] = $random;
	chunk_4[21:0] = $random;
	chunk_5[21:0] = $random;
	chunk_6[21:0] = $random;
	chunk_7[21:0] = $random;
	chunk_8[21:0] = $random;
	buffer_chunk[21:0] = $random;
	
	//Zero buffers
	chunk_1[31:22] = 10'b0;
	chunk_2[31:22] = 10'b0;
	chunk_3[31:22] = 10'b0;
	chunk_4[31:22] = 10'b0;
	chunk_5[31:22] = 10'b0;
	chunk_6[31:22] = 10'b0;
	chunk_7[31:22] = 10'b0;
	chunk_8[31:22] = 10'b0;
	buffer_chunk[31:22] = 10'b0;
	
	//Create random 256 bit table form random chunks
	reg [287:0] random_table = {chunk_1, chunk_2, chunk_3, chunk_4, chunk_5, chunk_6, chunk_7, chunk_8, buffer_chunk};
	
	//Create Memory Connections
	reg [10:0] memory_out = 10'b0;
	wire access_p2, wren;
	wire [1:0] access_type;
	wire [7:0] data_in;
	wire [7:0] result;
	
	ram_unit ram1(.clock(CLOCK_50), .access_p2(access_p2), .access_type(access_type), .data_in(data_in), .wren(wren), .result(result));
	
	//CAN ONLY WRITE TO MEMORY WHEN process == 100
	access_values access_vals(.process(process), .access_p2(access_p2), .access_type(access_type), .data_in(data_in), .wren(wren));
	
	always @(CLOCK_50)
	begin
		memory_out <= {process, result};
	end
	
	//Main Controller
	main_control mc(.start_signal(~KEY[0]), .load_signal(~KEY[1]), .finished_transaction(finished_transaction), .resetn(main_control_reset),
					.clock(CLOCK_50), .load_amount(load_amount), .load_key(load_key), .load_screen(load_main_screen), .start_animation(start_animation));
	
	//Main Controller for Transaction
	main_transaction_control mtc(.start_transaction(start_animation), .done_step(done_process), .done_travel(done_travel), .return_signal(~KEY[0]),
						.resetn(animations_reset), .clock(CLOCK_50), .finished_transaction(finished_transaction), .step(process), .travel(travel));
	
	//Datapath for verifying Info.
	verify_datapath verdata(.clock(CLOCK_50), .random_table(random_table), .memory_out(memory_out), .input_amount(SW[7:0]), .input_key(SW[7:0]), .load_amount(load_amount), .load_key(load_key), .resetn(data_reset), .done_step(done_process));
endmodule
