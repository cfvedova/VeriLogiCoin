//step == 001 if Verify_Amount; == 010 if Verify_Signature; == 011 if Finalize_Transaction; == 100 if Mine_Block; == 101 if Update_Chain; == 000 if no step
module animations_control(start_animation, done_step, done_travel, return_signal, resetn, clock, load_screen, finished_transaction, step, travel);
	input start_animation, done_step, done_travel, return_signal, resetn, clock;
    output reg load_screen, finished_transaction;
	output reg [2:0] step;
	output reg [2:0] travel; //The bit of travel tells which travel it is on. travel1 == 001, etc. And not travel == 000.
    reg [2:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state
	
	//start is a buffer
    localparam buffer = 4'b0000, start = 4'b0001, travel1 = 4'b0010, Verify_Amount = 4'b0011, travel2 = 4'b0100, Verify_Signature = 4'b0101,
	localparam travel3 = 4'b0110, Finalize_Transaction = 4'b0111, travel4 = 4'b1000, Mine_Block = 4'b1001, travel5 = 4'b1010, Update_Chain = 4'b1011;
	localparam Done_Animation = 4'b1100;
    
    always @(*)
    begin   // Start of state_table
        case (y_Q)
            buffer: begin
				if (!start_animation) Y_D = buffer;
				else Y_D = start;
			end
			start: begin
				if (!done_display) Y_D = start;
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
				else Y_D = Finalize_Transaction;
				end
			Finalize_Transaction: begin
				if(!done_step) Y_D = Finalize_Transaction;
				else Y_D = travel4;
			end
			travel4: begin
			    if(!done_travel) Y_D = travel4;
			    else Y_D = Mine_Block;
			end
			Mine_Block: begin
			    if(!done_step) Y_D = Mine_Block;
			    else Y_D = travel5;
			end
			travel5: begin
			    if(!done_travel) Y_D = travel5;
			    else Y_D = Update_Chain;
			end
			Update_Chain: begin
			    if(!done_step) Y_D = Update_Chain;
			    else Y_D = Done_Animation;
			end
			Done_Animation: begin
			    if(!return_signal) Y_D = Done_Animation;
			    else begin
					Y_D = buffer;
					finished_transaction = 1'b1;
			    end
			end
            default: Y_D = buffer;
        endcase
    end     // End of state_table
	
	// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        load_screen = 1'b0;
		travel[2:0] = 3'b000;
		step[2:0] = 3'b000
		finished_transaction = 1'b0;
		
        case (Y_Q)
            buffer: begin
				load_screen = 1'b0;
				travel[2:0] = 3'b000;
				step[2:0] = 3'b000;
				finished_transaction = 1'b0;
			end
            start: begin
                load_screen = 1'b1;
			end
			travel1: begin
                travel[2:0] = 3'b001;
				step[2:0] = 3'b001;
				load_screen = 1'b0;
			end
			Verify_Amount: begin
				travel[2:0] = 3'b000;
			end
			travel2: begin
                travel[2:0] = 3'b010;
				step[2:0] = 3'b010;
			end
			Verify_Signature: begin
				travel[2:0] = 3'b000;
			end
			travel3: begin
                travel[2:0] = 3'b011;
				step[2:0] = 3'b011;
			end
			Finalize_Transaction: begin
				travel[2:0] = 3'b000;
			end
			travel4: begin
                travel[2:0] = 3'b100;
				step[2:0] = 3'b100;
			end
			Mine_Block: begin
				travel[2:0] = 3'b000;
			end
			travel5: begin
                travel[2:0] = 3'b101;
				step[2:0] = 3'b101;
			end
			Update_Chain: begin
				travel[2:0] = 3'b000;
			end
			Done_Animation: begin
                step[2:0] == 3'b000;
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