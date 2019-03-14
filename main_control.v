//load_signal and start_signal are active high; finished_transaction signifies end of the animations fsa
//load_screen signifies accessing the memory for the money of p1 and p2 to display it.
//finished_transaction 
module main_control(start_signal, load_signal, finished_transaction, resetn, clock, load_amount, load_key, load_screen, start_animation);
	input start_signal, load_signal, finished_transaction, resetn, clock;
    output reg load_screen, load_amount, load_key, initialize_done, start_animation;
	
    reg [2:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state

    localparam start = 3'b000, Load_Amount = 3'b001, wait1 = 3'b010, Load_Key = 3'b011, wait2 = 3'b100, Animations = 3'b101;
    
    always @(*)
    begin   // Start of state_table
        case (y_Q)
            start: begin
                   if (!load_signal) Y_D = start;
                   else Y_D = Load_Amount;
		    end
            Load_Amount: begin
                   if(load_signal) Y_D = Load_Amount;
                   else Y_D = wait1;
		    end
            wait1: begin
                   if(!load_signal) Y_D = wait1;
                   else Y_D = Load_Key;
		    end
            Load_Key: begin
                   if(load_signal) Y_D = Load_Key;
                   else Y_D = wait2;
		    end
            wait2: begin
                   if(!start_signal) Y_D = wait2;
                   else Y_D = Animations;
		    end
            Animations: begin
                   if(!finished_transaction) Y_D = Animations;
				   else Y_D = start;
				   end
            default: Y_D = start;
        endcase
    end     // End of state_table
	
	// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        load_amount = 1'b0;
		load_key = 1'b0;
		load_screen = 1'b0;
		start_animation = 1'b0;
		initialize_done = 1'b0;
		
        case (Y_Q)
            start: begin
				load_amount = 1'b0;
				load_key = 1'b0;
				start_animation = 1'b0;
				load_screen = 1'b1;
			end
            Load_Amount: begin
                load_amount = 1'b1;
				load_screen = 1'b0;
			end
            wait1: begin
                load_amount = 1'b0;
			end
            Load_Key: begin
                load_key = 1'b1;
			end
            wait2: begin
                load_key = 1'b0;
				initialize_done = 1'b1;
            end
			Animations: begin
				initialize_done = 1'b0;
				start_animation = 1'b1;
            end
        endcase
    end // enable_signals
	
    // State Register
    always @(posedge clock)
    begin   // Start of state_FFs (state register)
        if(resetn == 1'b0)
            y_Q <= start;
        else
            y_Q <= Y_D;
    end     // End of state_FFs (state register)
endmodule