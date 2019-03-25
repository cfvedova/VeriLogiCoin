module bar_graph_display(clk, resetn, start_x, start_y, graph_height, enable, x_coord, y_coord, done);
    input clk;
    input resetn;
	input [8:0] start_x; // 0 -> 320
	input [7:0] start_y; // 0 -> 240
	input enable;  
	input [6:0] graph_height; // 0 -> 100
    output [8:0] x_coord; // X value to plot
	output [7:0] y_coord; // Y value to plot
	output done;

    
    // input registers
    reg [8:0] x;
	reg [7:0] y;

    // store iteration count
	reg [2:0] offset_x; //Bar graph is 8 pixels wide
	reg [6:0] offset_y; // Bar graph is at most 100 pixels tall
	wire y_enable;
    
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            x <= start_x;
			y <= start_y;
        end
    end


    // counter for x
	always @(posedge clk) begin
		if (!resetn)
			offset_x <= 3'b0;
		else if (enable) begin
			if (offset_x != 3'b111) //Width is at most 8 pixels
				offset_x <= offset_x + 1'b1;
			else 
				offset_x <= 3'b0;
		end
	end
	
	assign y_enable = (offset_x == 3'b111) ? 1 : 0;
	
	// counter for y
	always @(posedge clk) begin
		if (!resetn)
			offset_y <= 7'b0;
		else if (enable && y_enable) begin
			if (offset_y != graph_height) // Height is at most 100 pixels
				offset_y <= offset_y + 1'b1;
			else 
				offset_y <= 7'b0;
		end
	end

	assign x_coord = x + offset_x;
	assign y_coord = y + offset_y; 
	assign done = (offset_x == 3'b111 && offset_y == graph_height) ? 1: 0;
endmodule