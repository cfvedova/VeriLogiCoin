`include "vga_adapter/vga_adapter.v"
`include "vga_adapter/vga_address_translator.v"
`include "vga_adapter/vga_controller.v"
`include "vga_adapter/vga_pll.v"
`include "bar_graph_display_one_counter.v"
`include "transaction_display.v"
module money_display(clock, memory_out, load_memory, resetn, blackout, done_plotting,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);
	input clock;
	input [47:0] memory_out;
	input load_memory;
	input resetn;
	input blackout;
	
	output done_plotting;
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire [8:0] p1_x_plot;
	wire [7:0] p1_y_plot;
	wire p1_done;
	wire p1_black_done;
	wire p1_black_x_plot;
	wire p1_black_y_plot;
	
	wire [8:0] p2_x_plot;
	wire [7:0] p2_y_plot;
	wire p2_done;
	wire p2_black_done;
	wire p2_black_x_plot;
	wire p2_black_y_plot;
	
	wire [7:0] p1_bar_height = memory_out[31:24];
	wire [7:0] p2_bar_height = memory_out[7:0];
	
	wire [8:0] t1_x_plot;
	wire [7:0] t1_y_plot;
	wire t1_done;
	
	reg [8:0] x_plot;
	reg [7:0] y_plot;
	reg [2:0] plot_colour;
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(clock),
			.colour(plot_colour),
			.x(x_plot),
			.y(y_plot),
			.plot(!p2_done || !p2_black_done),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.	
	
	bar_graph_display_one_counter p1_money(
		.clk(clock),
		.resetn(resetn),
		.start_x(9'b00011111),
		.start_y(8'b11001010),
		.graph_height(p1_bar_height),
		.enable(t1_done),
		.x_coord(p1_x_plot),
		.y_coord(p1_y_plot),
		.done(p1_done));
	
	bar_graph_display_one_counter p2_money(
		.clk(clock),
		.resetn(resetn),
		.start_x(9'b11101111),
		.start_y(8'b11001010),
		.graph_height(p2_bar_height),
		.enable(p1_done && load_memory),
		.x_coord(p2_x_plot),
		.y_coord(p2_y_plot),
		.done(p2_done));
		
	transaction_display t1(
		.clk(clock), 
		.resetn(resetn), 
		.start_x(9'b001001000), 
		.start_y(8'b11000000), 
		.enable(load_memory), 
		.x_coord(t1_x_plot), 
		.y_coord(t1_y_plot), 
		.done_drawing(t1_done));
		
		
	bar_graph_display_one_counter p1_black(
		.clk(clock),
		.resetn(resetn),
		.start_x(9'b00011111),
		.start_y(8'b11001010),
		.graph_height(8'b11111111),
		.enable(blackout),
		.x_coord(p1_black_x_plot),
		.y_coord(p1_black_y_plot),
		.done(p1_black_done));

	bar_graph_display_one_counter p2_black(
		.clk(clock),
		.resetn(resetn),
		.start_x(9'b11101111),
		.start_y(8'b11001010),
		.graph_height(8'b11111111),
		.enable(p1_black_done),
		.x_coord(p2_black_x_plot),
		.y_coord(p2_black_y_plot),
		.done(p2_black_done));
		
	assign done_plotting = p2_black_done;
	
	always @(posedge clock) begin
		if (blackout) begin
			plot_colour <= 3'b0;
			if (!p1_black_done) begin
				x_plot <= p1_black_x_plot;
				y_plot <= p1_black_y_plot;
			end
			else begin
				x_plot <= p2_black_x_plot;
				y_plot <= p2_black_y_plot;
			end
		
		end
		else begin
			if (!t1_done) begin
				x_plot <= t1_x_plot;
				y_plot <= t1_y_plot;
				plot_colour <= 3'b111;
			end
			else if (!p1_done) begin
				x_plot <= p1_x_plot;
				y_plot <= p1_y_plot;
				plot_colour <= 3'b010;
			end
			else begin
				if (!p2_done) begin
					x_plot <= p2_x_plot;
					y_plot <= p2_y_plot;
					plot_colour <= 3'b010;
				end
			end
		end
	end
endmodule
