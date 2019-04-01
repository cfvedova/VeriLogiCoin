module transaction_display(clk, resetn, start_x, start_y, enable, x_coord, y_coord, done_drawing);
	input clk;
	input resetn;
	input [8:0] start_x; //320 pixels wide
	input [7:0] start_y; //240 pixels tall
	input enable;  
    output reg [8:0] x_coord; // X value to plot
	output reg [7:0] y_coord; // Y value to plot
	output done_drawing;
	
	// Connection between each drawing component
	wire start_two;
	wire start_three;
	wire start_four;
	wire start_five;
	wire start_six;
	wire start_seven;
	wire done;
	
	assign done_drawing = done;

	//Measure what stage of drawing is complete
	reg [2:0] step_count;
	always @(clk) begin
		step_count <= start_two + start_three + start_four + start_five + start_six + start_seven;
	end

	
	//Outputs from each step
	wire [8:0] step1_x;
	wire [7:0] step1_y;
	wire [8:0] step2_x;
	wire [7:0] step2_y;
	wire [8:0] step3_x;
	wire [7:0] step3_y;
	wire [8:0] step4_x;
	wire [7:0] step4_y;
	wire [8:0] step5_x;
	wire [7:0] step5_y;
	wire [8:0] step6_x;
	wire [7:0] step6_y;
	wire [8:0] step7_x;
	wire [7:0] step7_y;
	
	//Drawing
	verification_connection_display step1(.clk(clk), .resetn(resetn), .start_x(start_x), .start_y(start_y), .enable(enable), .x_coord(step1_x), .y_coord(step1_y), .complete(start_two));
	verification_process_display step2(.clk(clk), .resetn(resetn), .start_x(start_x + 16), .start_y(start_y - 8), .enable(start_two), .x_coord(step2_x), .y_coord(step2_y), .complete(start_three));
	verification_connection_display step3(.clk(clk), .resetn(resetn), .start_x(start_x + 32), .start_y(start_y), .enable(start_three), .x_coord(step3_x), .y_coord(step3_y), .complete(start_four));
	verification_process_display step4(.clk(clk), .resetn(resetn), .start_x(start_x + 48), .start_y(start_y - 8), .enable(start_four), .x_coord(step4_x), .y_coord(step4_y), .complete(start_five));
	verification_connection_display step5(.clk(clk), .resetn(resetn), .start_x(start_x + 64), .start_y(start_y), .enable(start_five), .x_coord(step5_x), .y_coord(step5_y), .complete(start_six));
	verification_process_display step6(.clk(clk), .resetn(resetn), .start_x(start_x + 80), .start_y(start_y - 8), .enable(start_six), .x_coord(step6_x), .y_coord(step6_y), .complete(start_seven));
	verification_connection_display step7(.clk(clk), .resetn(resetn), .start_x(start_x + 96), .start_y(start_y), .enable(start_seven), .x_coord(step7_x), .y_coord(step7_y), .complete(done));
	

	//Assign plotting points to the current display block
	always @(clk) 	// declare always block
	begin
		case (step_count) // start case statement
			3'b000: begin
					x_coord <= step1_x; // step 1
					y_coord <= step1_y;
			end
			3'b001: begin
					x_coord <= step2_x; // step 2
					y_coord <= step2_y;
			end
			3'b010: begin
					x_coord <= step3_x; // step 3
					y_coord <= step3_y;
			end
			3'b011: begin
					x_coord <= step4_x; // step 4
					y_coord <= step4_y;
			end
			3'b100: begin
					x_coord <= step5_x; // step 5
					y_coord <= step5_y;
			end
			3'b101: begin
					x_coord <= step6_x; // step 6
					y_coord <= step6_y;
			end
			3'b110: begin
					x_coord <= step7_x; // step 7
					y_coord <= step7_y;
			end
			default: begin
					x_coord <= start_x;
					y_coord <= start_y;
			end
		endcase
	end

endmodule

module verification_connection_display(clk, resetn, start_x, start_y, enable, x_coord, y_coord, complete);
    input clk;
    input resetn;
	input [8:0] start_x; // 0 -> 320
	input [7:0] start_y; // 0 -> 240
	input enable;  
    output [8:0] x_coord; // X value to plot
	output [7:0] y_coord; // Y value to plot
	output reg complete; 

    // store iteration count (32x2 draw)
	reg [5:0] counter; // [5] -> offset_y [4:0] ->offset_x
  
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            complete <= 1'b0;
			counter <= 6'b0;
        end		
		else begin
			if (enable) begin
				if (counter != 6'b111111) begin
					counter <= counter + 1'b1;
				end
				else begin
					complete <= 1'b1;
				end
			end
		end
    end

	assign x_coord = start_x + counter[4:0];
	assign y_coord = start_y + counter[5]; 
endmodule

module verification_process_display(clk, resetn, start_x, start_y, enable, x_coord, y_coord, complete);
    input clk;
    input resetn;
	input [8:0] start_x; // 0 -> 320
	input [7:0] start_y; // 0 -> 240
	input enable;  
    output [8:0] x_coord; // X value to plot
	output [7:0] y_coord; // Y value to plot
	output reg complete;

    // store iteration count (32x32 draw)
	reg [9:0] counter; // [9:5] -> offset_y [4:0] ->offset_x
  
    // Registers x, y with respective input logic
    always @ (posedge clk) begin
        if (!resetn) begin
            complete <= 1'b0;
			counter <= 10'b0;
        end		
		else begin
			if (enable) begin
				if (counter != 10'b1111111111) begin
					counter <= counter + 1'b1;
				end
				else begin
					complete <= 1'b1;
				end
			end
		end
    end

	assign x_coord = start_x + counter[9:6];
	assign y_coord = start_y + counter[4:0];   
endmodule