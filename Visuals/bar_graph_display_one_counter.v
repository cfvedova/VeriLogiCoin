module bar_graph_display_one_counter(clk, resetn, start_x, start_y, graph_height, enable, x_coord, y_coord, done);
    input clk;
    input resetn;
	input [8:0] start_x; // 0 -> 320
	input [7:0] start_y; // 0 -> 240
	input enable;  
	input [6:0] graph_height; // 0 -> 100
    output [8:0] x_coord; // X value to plot
	output [7:0] y_coord; // Y value to plot
	output reg done;

    // store iteration count
	reg [9:0] counter; // counter[9:3] is y plot, counter [2:0] is x plot

    
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
			done <= 1'b0;
			counter <= 10'b0;
        end
		else begin
			if (enable) begin
				if (counter[9:3] != graph_height[6:0] || counter[2:0] != 3'b111) begin
					counter <= counter + 1'b1;
				end
				else begin
					done <= 1'b1;
				end
			end
		end
    end

	assign x_coord = start_x + counter[2:0];
	assign y_coord = start_y + counter[9:3]; 
endmodule