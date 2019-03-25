//load_signal and start_signal are active high; finished_transaction signifies end of the animations fsa
//load_memory signifies accessing the memory for the money of p1 and p2 to display it.
//finished_transaction 
module main_control(start_signal, load_signal, finished_init, finished_transaction, resetn, clock, done_table_init, reset_others, load_amount, load_key, load_memory, init_memory, start_transaction, random_init, global_reset);
	input start_signal, load_signal, finished_init, finished_transaction, resetn, clock, done_table_init;
    output reg init_memory, load_memory, load_amount, load_key, start_transaction, reset_others, random_init, global_reset;
	
    reg [2:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state

    localparam start = 4'b0000, Load_Amount = 4'b0001, wait1 = 4'b0010, Load_Key = 4'b0011, wait2 = 4'b0100, Transaction = 4'b0101, Reset_Others = 4'b0110, INIT1 = 4'b0111, INIT2 = 4'b1000, Startup = 4'b1001;
	
	reg [1:0] reset_others_counter;
	reg start_reset_others_counter;
	
	always @(posedge clock) begin
		if ((!global_reset) || (reset_others)) begin
			reset_others_counter = 2'b0;
		end
		else 
		begin
			if (start_reset_others_counter) begin
				reset_others_counter <= reset_others_counter + 1'b1;
			end
		end		
	end
	
    always @(*)
    begin   // Start of state_table
        case (y_Q)
			Startup: begin
				if (!load_signal) Y_D = INIT1;
				else Y_D = INIT1;
			end
			INIT1: begin
				if (done_table_init) Y_D = INIT1;
				else Y_D = INIT2;
			end
			INIT2: begin
				if (!finished_init) Y_D = INIT2;
				else Y_D = Reset_Others;
			end
			
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
                   else Y_D = Transaction;
		    end
            Transaction: begin
                   if(!finished_transaction) Y_D = Transaction;
				   else Y_D = Reset_Others;
			end
			Reset_Others: begin
				if(reset_others_counter != 2'b11) Y_D = Reset_Others;
				else Y_D = Start;
			end
            default: Y_D = Startup;
        endcase
    end     // End of state_table
	
	// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        load_amount = 1'b0;
		load_key = 1'b0;
		load_memory = 1'b0;
		start_transaction = 1'b0;
		reset_others = 1'b1;
		init_memory = 1'b0;
		random_init = 1'b0;
		global_reset = 1'b1;
		start_reset_others_counter = 1'b0;
		
        case (y_Q)
			Startup: begin
				global_reset = 1'b0;
			end
            start: begin
				load_amount = 1'b0;
				load_key = 1'b0;
				start_transaction = 1'b0;
				load_memory = 1'b1;
				reset_others = 1'b1;
				init_memory = 1'b0;
				start_reset_others_counter = 1'b0;
			end
            Load_Amount: begin
                load_amount = 1'b1;
				load_memory = 1'b0;
				start_reset_others_counter = 1'b0;
			end
            wait1: begin
                load_amount = 1'b0;
			end
            Load_Key: begin
                load_key = 1'b1;
			end
            wait2: begin
                load_key = 1'b0;
            end
			Transaction: begin
				start_transaction = 1'b1;
				start_reset_others_counter = 1'b0;
			end
			Reset_Others: begin
				reset_others = 1'b0;
				start_reset_others_counter = 1'b1;
            end
			INIT1: begin
				global_reset = 1'b1;
				random_init = 1'b1;
			end
			INIT2: begin
				init_memory = 1'b1;
				start_reset_others_counter = 1'b0;
			end
        endcase
    end // enable_signals
	
    // State Register
    always @(posedge clock)
    begin   // Start of state_FFs (state register)
        if(resetn == 1'b0) begin
            y_Q <= start;
			end
        else begin
            y_Q <= Y_D;
			end
    end     // End of state_FFs (state register)
endmodule