module bar_graph_datapath(clk, resetn, start_x, start_y, enable, coord_x, coord_y);
    input clk
    input resetn
	input [9:0] start_x // 0 -> 640
	input [8:0] start_y // 0 -> 480
	input [2:0] color_in // VGA color encodings
	input enable  
    output [9:0] x_coord // X value to plot
	output [8:0] y_coord // Y value to plot
	output [2:0] color_out

    
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