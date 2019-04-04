module plot_black(clk, resetn, enable, x_coord, y_coord, done);
    input clk;
    input resetn;
	input enable;  
    output [8:0] x_coord; // X value to plot
	output [7:0] y_coord; // Y value to plot
	output reg done;

    // store iteration count
	reg [16:0] counter; // counter[16:8] is x plot, counter [7:0] is y plot

    
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
			done <= 1'b0;
			counter <= 17'b0;
        end
		else begin
			if (enable) begin
				if (counter[16:8] != (9'b111111111) || counter[7:0] != (8'b11111111)) begin
					counter <= counter + 1'b1;
				end
				else begin
					done <= 1'b1;
				end
			end
		end
    end

	assign x_coord = 9'b0 + counter[16:8];
	assign y_coord = 8'b0 + counter[7:0]; 
endmodule