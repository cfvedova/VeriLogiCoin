//Main will connect the keyboard to the actual program

`include "Controllers/main_control.v"
`include "Controllers/main_transaction_control.v"
`include "Datapath/datapath.v"
`include "Memory/access_values.v"
`include "Memory/store_values.v"

module main(SW, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	
	//Wires for main_control
	wire main_control_reset;
	wire load_amount;
	wire load_key;
	wire load_main_screen;
	
	//Connections between controls
	wire finished_transaction;
	wire start_animation;
	
	//Wires for transaction_control
	reg done_process;
	wire done_travel;
	wire animations_reset;
	wire [2:0] process;
	wire [2:0] travel;
	
	//Wires for Datapath
	wire data_reset;
	wire [10:0] p1_amount_out;
	wire [10:0] p2_amount_out;
	
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
	wire [287:0] random_table = {chunk_1, chunk_2, chunk_3, chunk_4, chunk_5, chunk_6, chunk_7, chunk_8, buffer_chunk};
	
	//Create Memory Connections
	reg [10:0] memory_out = 10'b0;
	wire access_p2, wren;
	wire [1:0] access_type;
	wire [7:0] data_in;
	wire [7:0] result;
	
	ram_unit ram1(.clock(CLOCK_50), .access_p2(access_p2), .access_type(access_type), .data_in(data_in), .wren(wren), .result(result));
	
	wire [2:0] protocol;
	//CAN ONLY WRITE TO MEMORY WHEN process == 100
	access_values access_vals(.process(process), .second_player(counter0), .protocol(protocol) .access_p2(access_p2), .access_type(access_type), .data_in(data_in), .wren(wren));
	
	reg [1:0] counter0;
	always @(CLOCK_50)
	begin
		if(process == 3'b100) begin
			case(counter0)
				2'b00: counter0 <= counter0 + 1;
				2'b01: counter0 <= counter0 + 1;
				2'b10: counter0 <= counter0 + 1;
				2'b11: counter0 <= counter0 + 1;
			endcase
		end
		else begin
			counter0 <= 2'b0;
		end
	end
	
	
	always @(CLOCK_50)
	begin
		memory_out <= {protocol, result};
	end
	
	reg [10:0] message;
	store_values store_vals(.message(message), .access_p2_out(access_p2), .access_type_out(access_type), .data_out(data_in), .wren(wren))
	
	//Write both the p1 and p2 amounts to memory
	reg done_memory_store;
	reg [1:0] counter1;
	always @(p2_amount_out, counter)
	begin
		if ((process == 3'b100) && done_data_process)
		begin
			case(counter)
				2'b00: begin
					message <= p1_amount_out;
					counter <= counter + 1;
				end
				2'b01: begin
					message <= p2_amount_out;
					counter <= counter + 1;
				end
				2'b10: counter <= counter + 1;
				2'b11: done_memory_store <= 1'b1;
			endcase
		end
		else begin
			done_memory_store <= 1'b0;
			counter <= 2'b0;
			message <= 11'b0;
		end
	end
	
	//Main Controller
	main_control mc(.start_signal(~KEY[0]), .load_signal(~KEY[1]), .finished_transaction(finished_transaction), .resetn(main_control_reset),
					.clock(CLOCK_50), .load_amount(load_amount), .load_key(load_key), .load_screen(load_main_screen), .start_animation(start_animation));
	
	always @(CLOCK_50)
	begin
		case (process)
			3'b001: done_process <= done_data_process;
			3'b010: done_process <= done_data_process;
			3'b011: done_process <= 1'b1;
			3'b100: done_process <= done_memory_store;
			default: done_step <= 1'b0;
		endcase
	end
	//Main Controller for Transaction
	main_transaction_control mtc(.start_transaction(start_animation), .done_step(done_process), .done_travel(done_travel), .return_signal(~KEY[0]),
						.resetn(animations_reset), .clock(CLOCK_50), .finished_transaction(finished_transaction), .step(process), .travel(travel));
	
	//Datapath for verifying Info.
	datapath verdata(.clock(CLOCK_50), .random_table(random_table), .memory_out(memory_out), .input_amount(SW[7:0]), .input_key(SW[7:0]), .load_amount(load_amount), .load_key(load_key), .resetn(data_reset), .done_step(done_data_process), .p1_amount_out(p1_amount_out), .p2_amount_out(p2_amount_out));
endmodule
