module money_display(CLOCK_50, memory_out, load_memory, resetn, 
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);
	input CLOCK_50;
	input [47:0] memory_out;
	input load_memory;
	input resetn;
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(3'b100),
			.x(x_plot),
			.y(y_plot),
			.plot(!p2_done),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.	
	wire [9:0] p1_x_plot;
	wire [8:0] p1_y_plot;
	wire p1_done;
	
	wire [9:0] p2_x_plot;
	wire [8:0] p2_y_plot;
	wire p2_done;
	
	bar_graph_display p1_money(
		.clk(CLOCK_50),
		.resetn(resetn),
		.start_x(10'b0001010000),
		.start_y(9'b001010000),
		.graph_height(memory_out[31:24]),
		.enable(load_memory),
		.x_coord(p1_x_plot),
		.y_coord(p1_y_plot),
		.done(p1_done));
	
	bar_graph_display p2_money(
		.clk(CLOCK_50),
		.resetn(resetn),
		.start_x(10'b1000110000),
		.start_y(9'b001010000),
		.graph_height(memory_out[7:0]),
		.enable(p1_done && load_memory),
		.x_coord(p2_x_plot),
		.y_coord(p2_y_plot),
		.done(p2_done));
		
	reg [9:0] x_plot;
	reg [8:0] y_plot;
	
	always @(*) begin
		if (!p1_done) begin
			x_plot <= p1_x_plot;
			y_plot <= p1_y_plot;
		end
		else begin
			x_plot <= p2_x_plot;
			x_plot <= p2_y_plot
		end
	end
endmodule