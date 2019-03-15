//Main will connect the keyboard to the actual program

`include "controllers/main_control.v"
`include "controllers/main_transaction_control.v"

module main(SW, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	
	//Wires for main_control
	wire main_control_reset, load_amount, load_key, load_main_screen;
	
	//Connections between controls
	wire finished_transaction, start_animation;
	
	//Wires for animations_control
	wire done_process, done_travel, animations_reset;
	wire [1:0] process;
	wire [2:0] travel;
	
	
	main_control mc(.start_signal(KEY[0]), .load_signal(KEY[1]), .finished_transaction(finished_transaction), .resetn(main_control_reset),
					.clock(CLOCK_50), .load_amount(load_amount), .load_key(load_key), .load_screen(load_main_screen), .start_animation(start_animation));
	
	animations_control ac(.start_animation(start_animation), .done_step(done_process), .done_travel(done_travel), .return_signal(KEY[0]),
						.resetn(animations_reset), .clock(CLOCK_50), .finished_transaction(finished_transaction),
						.step(process), .travel(travel));
endmodule
