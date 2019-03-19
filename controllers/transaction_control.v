//step == 001 if Verify_Amount; == 010 if Verify_Signature; == 011 if Mine_Block; 100 if Finish_Transaction (Make sure computation is complete); == 00 if no step
module transaction_control(start_transaction, done_step, done_travel, resetn, clock, finished_transaction, step, travel);
	input start_transaction, done_step, done_travel, resetn, clock;
	output reg [2:0] step;
	output reg [2:0] travel; //The bit of travel tells which travel it is on. travel1 == 001, etc. And not travel == 000.
	
    reg [3:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state
	
	//start is a buffer
    localparam buffer = 4'b0000, travel1 = 4'b0001, Verify_Amount = 4'b0010, travel2 = 4'b0011, Verify_Signature = 4'b0100,
			   travel3 = 4'b0101, Mine_Block = 4'b0110, travel4 = 4'b0111, Finish_Transaction = 4'b1000;
	
    always @(*)
    begin   // Start of state_table
        case (y_Q)
            buffer: begin
				if (!start_transaction) Y_D = buffer;
				else Y_D = travel1;
			end
            travel1: begin
				if(!done_travel) Y_D = travel1;
				else Y_D = Verify_Amount;
			end
            Verify_Amount: begin
				if(!done_step) Y_D = Verify_Amount;
				else Y_D = travel2;
			end
            travel2: begin
				if(!done_travel) Y_D = travel2;
				else Y_D = Verify_Signature;
			end
            Verify_Signature: begin
				if(!done_step) Y_D = Verify_Signature;
				else Y_D = travel3;
			end
            travel3: begin
				if(!done_travel) Y_D = travel3;
				else Y_D = Mine_Block;
			end
			Mine_Block: begin
			    if(!done_step) Y_D = Mine_Block;
			    else Y_D = travel4;
			end
			travel4: begin
			    if(!done_travel) Y_D = travel4;
			    else Y_D = Finish_Transaction;
			end
			Finish_Transaction: begin
			    if(!done_step) begin
					Y_D = Finish_Transaction;
				end
				 else begin
					Y_D = buffer;
			    end
			end
            default: Y_D = buffer;
        endcase
    end     // End of state_table
	
	// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		travel[2:0] = 3'b0;
		step[2:0] = 3'b0;
		
        case (y_Q)
            buffer: begin
				travel[2:0] = 3'b0;
				step[2:0] = 3'b0;
			end
			travel1: begin
            travel[2:0] = 3'b001;
				step[2:0] = 3'b001;
			end
			Verify_Amount: begin
				travel[2:0] = 3'b0;
			end
			travel2: begin
                travel[2:0] = 3'b010;
				step[2:0] = 3'b010;
			end
			Verify_Signature: begin
				travel[2:0] = 3'b0;
			end
			travel3: begin
                travel[2:0] = 3'b011;
				step[2:0] = 3'b011;
			end
			Mine_Block: begin
				travel[2:0] = 3'b000;
			end
			travel4: begin
                travel[2:0] = 3'b101;
			end
			Finish_Transaction: begin
				step[2:0] = 3'b100;
				travel[2:0] = 3'b0;
			end
        endcase
    end // enable_signals
	
    // State Register
    always @(posedge clock)
    begin   // Start of state_FFs (state register)
        if(resetn == 1'b0)
            y_Q <= buffer;
        else
            y_Q <= Y_D;
    end     // End of state_FFs (state register)
endmodule