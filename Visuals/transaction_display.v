module transaction_display(clk, resetn, start_x, start_y, enable, coord_x, coord_y, done_drawing);
	input clk;
	input resetn;
	input [9:0] start_x; //640 pixels wide
	input [8:0] start_y; //480 pixels tall
	input enable;  
    output reg [9:0] x_coord; // X value to plot
	output reg [8:0] y_coord; // Y value to plot
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
	assign step_count = start_two + start_three + start_four + start_five + start_six + start_seven;
	
	//Outputs from each step
	wire [9:0] step1_x;
	wire [8:0] step1_y;
	wire [9:0] step2_x;
	wire [8:0] step2_y;
	wire [9:0] step3_x;
	wire [8:0] step3_y;
	wire [9:0] step4_x;
	wire [8:0] step4_y;
	wire [9:0] step5_x;
	wire [8:0] step5_y;
	wire [9:0] step6_x;
	wire [8:0] step6_y;
	wire [9:0] step7_x;
	wire [8:0] step7_y;
	
	//Drawing
	verification_connection_display step1(.clk(clk), .resetn(resetn), .start_x(start_x), .start_y(start_y), .enable(enable), .coord_x(step1_x), .coord_y(step1_y), .complete(start_two));
	verification_process_display step2(.clk(clk), .resetn(resetn), .start_x(start_x + 32), .start_y(start_y - 16), .enable(start_two), .coord_x(step2_x), .coord_y(step2_y), .complete(start_three));
	verification_connection_display step3(.clk(clk), .resetn(resetn), .start_x(start_x + 64), .start_y(start_y), .enable(start_three), .coord_x(step3_x), .coord_y(step3_y), .complete(start_four));
	verification_process_display step4(.clk(clk), .resetn(resetn), .start_x(start_x + 96), .start_y(start_y - 16), .enable(start_four), .coord_x(step4_x), .coord_y(step4_y), .complete(start_five));
	verification_connection_display step5(.clk(clk), .resetn(resetn), .start_x(start_x + 128), .start_y(start_y), .enable(start_five), .coord_x(step5_x), .coord_y(step5_y), .complete(start_six));
	verification_process_display step6(.clk(clk), .resetn(resetn), .start_x(start_x + 160), .start_y(start_y - 16), .enable(start_six), .coord_x(step6_x), .coord_y(step6_y), .complete(start_seven));
	verification_connection_display step7(.clk(clk), .resetn(resetn), .start_x(start_x + 192), .start_y(start_y), .enable(start_seven), .coord_x(step7_x), .coord_y(step7_y), .complete(done));
	

	//Assign plotting points to the current display block
	always @(clk) 	// declare always block
	begin
		case (step_count) // start case statement
			3'b000: x_coord <= step1_x; // step 1
					y_coord <= step1_y;
			3'b001: x_coord <= step2_x; // step 2
					y_coord <= step2_y;
			3'b010: x_coord <= step3_x; // step 3
					y_coord <= step3_y;
			3'b011: x_coord <= step4_x; // step 4
					y_coord <= step4_y;
			3'b100: x_coord <= step5_x; // step 5
					y_coord <= step5_y;
			3'b101: x_coord <= step6_x; // step 6
					y_coord <= step6_y;
			3'b110: x_coord <= step7_x; // step 7
					y_coord <= step7_y;
			default: x_coord <= start_x;
					y_coord <= start_y;
		endcase
	end

endmodule

module verification_connection_display(clk, resetn, start_x, start_y, enable, coord_x, coord_y, complete);
    input clk;
    input resetn;
	input [9:0] start_x; // 0 -> 640
	input [8:0] start_y; // 0 -> 480
	input enable;  
    output [9:0] x_coord; // X value to plot
	output [8:0] y_coord; // Y value to plot
	output complete; 

     
    // input registers
    reg [9:0] x;
	reg [8:0] y;

    // store iteration count
	reg [4:0] offset_x; //Connection signal is 32 pixels wide
	reg offset_y; // Connection signal is 2 pixels tall
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
			offset_y <= 1'b0;
		else if (enable && y_enable) begin
			if (offset_y != 1'b1) // Height is at most 2 pixels
				offset_y <= offset_y + 1'b1;
			else 
				offset_y <= 1'b0;
		end
	end

	assign x_coord = x + offset_x;
	assign y_coord = y + offset_y; 
	assign complete = ((x_coord == start_x + 32) && (y_coord == start_y + 2)) ? 1 : 0; //We plotted the entire line
endmodule

module verification_process_display(clk, resetn, start_x, start_y, enable, coord_x, coord_y, complete);
    input clk;
    input resetn;
	input [9:0] start_x; // 0 -> 640
	input [8:0] start_y; // 0 -> 480
	input enable;  
    output [9:0] x_coord; // X value to plot
	output [8:0] y_coord; // Y value to plot
	output complete;

     
    // input registers
    reg [9:0] x;
	reg [8:0] y;

    // store iteration count
	reg [4:0] offset_x; //Connection signal is 32 pixels wide
	reg [4:0] offset_y; // Connection signal is 32 pixels tall
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
			if (offset_y != 5'b11111) // Height is at most 32 pixels
				offset_y <= offset_y + 1'b1;
			else 
				offset_y <= 5'b0;
		end
	end

	assign x_coord = x + offset_x;
	assign y_coord = y + offset_y; 
	assign complete = ((x_coord == start_x + 32) && (y_coord == start_y + 32)) ? 1 : 0; //We plotted the entire box
endmodule