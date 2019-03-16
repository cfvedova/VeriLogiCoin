module bar_graph_display(clk, resetn, start_x, start_y, graph_height, enable, coord_x, coord_y);
    input clk;
    input resetn;
	input [9:0] start_x; // 0 -> 640
	input [8:0] start_y; // 0 -> 480
	input enable;  
	input [7:0] graph_height; // 0 -> 200
    output [9:0] x_coord; // X value to plot
	output [8:0] y_coord; // Y value to plot

    
    // input registers
    reg [9:0] x;
	reg [8:0] y;

    // store iteration count
	reg [4:0] offset_x; //Bar graph is 32 pixels wide
	reg [7:0] offset_y; // Bar graph is at most 200 pixels tall
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
			offset_x <= 5'b0;
		else if (enable) begin
			if (offset_x != 5'b11111) //Width is at most 32 pixels
				offset_x <= offset_x + 1'b1;
			else 
				offset_x <= 5'b0;
		end
	end
	
	assign y_enable = (offset_x == 5'b11111) ? 1 : 0;
	
	// counter for y
	always @(posedge clk) begin
		if (!resetn)
			offset_y <= 5'b0;
		else if (enable && y_enable) begin
			if (offset_y != 8b'11001000) // Height is at most 200 pixels
				offset_y <= offset_y + 1'b1;
			else 
				offset_y <= 8'b00000000;
		end
	end

	assign x_coord = x + offset_x;
	assign y_coord = y + offset_y; 
endmodule