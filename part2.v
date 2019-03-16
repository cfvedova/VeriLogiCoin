// Part 2 skeleton

module part2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
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
    wire ld_X, ld_Y, ld_C, x_enable;

    // Instansiate datapath
	datapath d0(.clk(CLOCK_50), .resetn(KEY[0]), .position(SW[6:0]), .color_in(SW[9:7]), .ld_X(ld_X), .ld_Y(ld_Y), .ld_C(ld_C), .x_enable(x_enable), .x_coord(x), .y_coord(y), .color(colour));

    // Instansiate FSM control
    control c0(.clk(CLOCK_50), .resetn(KEY[0]), .start(KEY[1]), .ld(KEY[3]), .ld_X(ldx), .ld_Y(ld_Y), .ld_C(ld_C), .writeEn(writeEn), .x_enable(x_enable));
endmodule

module datapath_m(
    input clk,
    input resetn,
	input [6:0] position,
	input [2:0] color_in,
    input ld_X, 
	input ld_Y,
	input ld_C,
	input x_enable,
    output [7:0] x_coord,
	output [6:0] y_coord,
	output [2:0] color_out);
    
    // input registers
    reg [7:0] x;
	reg [6:0] y;
	reg [2:0] color;

    // output of the alu
	reg [1:0] offset_x;
	reg [1:0] offset_y;
	wire y_enable;
    
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            x <= 8'd0;
			y <= 7'd0;
			color <= 3'd0;
        end
        else begin
            if (ld_X)
                x <= {1'd0, position}; // load alu_out if load_alu_out signal is high, otherwise load from data_in
            if (ld_Y)
                y <= position; // load alu_out if load_alu_out signal is high, otherwise load from data_in
			if (ld_C)
				color <= color_in;
        end
    end


    // counter for x
	always @(posedge clk) begin
		if (!resetn)
			offset_x <= 2'b00;
		else if (x_enable) begin
			if (offset_x == 2'b11)
				offset_x <= 2'b00;
			else begin
				offset_x <= offset_x + 1'b1;
			end
		end
	end
	
	assign y_enable = (offset_x == 2'b11) ? 1 : 0;
	
	// counter for y
	always @(posedge clk) begin
		if (!resetn)
			offset_y <= 2'b00;
		else if (x_enable && y_enable) begin
			if (offset_y != 2'b11)
				offset_y <= offset_y + 1'b1;
			else 
				offset_y <= 2'b00;
		end
	end
	

	assign x_coord = x + offset_x;
	assign y_coord = y + offset_y;
	assign color_out = color;
	
    
endmodule


module control(clk, resetn, start, ld, ld_X, ld_Y, ld_C, writeEn, x_enable);
	input clk, resetn, start, ld;
	output reg ld_X, ld_Y, ld_C, writeEn, x_enable;

	
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	localparam 	Load_x = 3'd0,
				Load_x_wait = 3'd1,
				Load_y = 3'd2,
				Load_y_wait = 3'd3,
				Go = 3'd4;
					
	// State Table
	always @(*) begin
		case (current_state)
			Load_x: next_state = ld ? Load_x_wait : Load_x;
			Load_x_wait: next_state = ld ? Load_x_wait : Load_y;
			Load_y: next_state = start ? Load_y : Load_y;
			Load_y_wait: next_state = start ? Load_y_wait : Go;
			Go: next_state = ld ? Load_x : Go;
		endcase
	end
	
	// Output Logic
	always @(*) begin
		ld_X = 1'b0;
		ld_Y = 1'b0;
		ld_X = 1'b0;
		writeEn = 1'b0;
		
		case (current_state)
			Load_x: begin
				ld_X <= 1;
				x_enable <= 1;
			end
			Load_x_wait: begin
				ld_X <= 1;
				x_enable <= 1;
			end
			Load_y: begin
				ld_Y <= 1; 
				ld_C <= 1;
				x_enable <= 1;
			end
			Load_y_wait: begin
				ld_Y <= 1; 
				ld_C <= 1;
				x_enable <= 1;
			end
			Go: begin
				writeEn <= 1; 
				x_enable <= 1;
			end
		endcase
	end
	
	//State Register
	always @(posedge clk) begin
		if (!resetn)
			current_state <= Load_x;
		else
			current_state <= next_state;
	end

endmodule
