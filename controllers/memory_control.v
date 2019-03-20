module memory_control(clock, resetn, load_memory, starting_memory, init_memory, datapath_out, process, write_enable, access_type, load_registers, data_in, done, finished_init);
	input clock, resetn, load_memory, init_memory;
	input [47:0] datapath_out;
	input [2:0] process;
	input [47:0] starting_memory;
	
	output reg write_enable, access_type, load_registers, done, finished_init;
	output reg [47:0] data_in;
	

	
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	//States
	localparam 	Init_memory = 3'd0,
				Buffer_1 = 3'd1,
				Load_data = 3'd2,
				Wait1 = 3'd3,
				Buffer_2 = 3'd4,
				Write_data = 3'd5;
	
	//Wait signals to give buffer time to memory access
	reg start_wait;
	reg start_wait1;
	reg start_wait2;
	reg start_wait3;
	reg [2:0] waited_1;
	reg [2:0] waited_2;
	reg [2:0] waited_3;
	reg [2:0] waited;
	
	always @(posedge clock) begin
		if (!resetn) begin
			waited <= 3'b0;
			waited_1 <= 3'b0;
			waited_2 <= 3'b0;
			waited_3 <= 3'b0;
		end
		else 
		begin
			if (start_wait) begin
				waited <= waited + 1'b1;
			end
			if (start_wait1) begin
			waited_1 <= waited_1 + 1'b1;
			end
			if (start_wait2) begin
			waited_2 <= waited_2 + 1'b1;
			end
			if (start_wait3) begin
			waited_3 <= waited_3 + 1'b1;
			end
		end		
	end
	
	// State Table
	always @(*) begin
		case (current_state)
			Init_memory: begin
				if (waited == 3'b111) next_state = Buffer_1;
				else next_state = Init_memory;
			end
            Buffer_1: begin
				   if (init_memory) next_state = Init_memory;
                   else if (load_memory) next_state = Load_data;
                   else next_state = Buffer_1;
		    end
            Load_data: begin
                   if(waited_1 == 3'b111) next_state = Wait1;
                   else next_state = Load_data;
		    end
			Wait1: begin 
				   if(waited_2 == 3'b111) next_state = Buffer_2;
				   else next_state = Wait1;
			end
            Buffer_2: begin
                   if(process == 3'b100) next_state = Write_data;
                   else next_state = Buffer_2;
		    end
            Write_data: begin
                   if(waited_3 == 3'b111) next_state = Buffer_1;
                   else next_state = Write_data;
		    end
          default: next_state = Buffer_1;
        endcase
	end
	
	// Output Logic
	always @(*) begin
		start_wait <= 1'b0;
		start_wait1 = 1'b0;
		start_wait2 = 1'b0;
		start_wait3 <= 1'b0;
		write_enable = 1'b0;
		done = 1'b0;
		access_type = 1'b0;
		finished_init <= 1'b0;
		
		case (current_state)
			Init_memory: begin
				finished_init <= 1'b0;
				start_wait <= 1'b1;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait3 <= 1'b0;
				load_registers <= 1'b0;
				write_enable <= 1'b1;
				done <= 1'b0;
				access_type = 1'b0;
				data_in <= starting_memory;
			end
			Buffer_1: begin
				finished_init <= 1'b1;
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait3 <= 1'b0;
				load_registers <= 1'b0;
				write_enable <= 1'b0;
				done <= 1'b1;
				access_type = 1'b0;
				data_in <= datapath_out;
			end
			Load_data: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b1;
				start_wait2 <= 1'b0;
				start_wait3 <= 1'b0;
				load_registers <= 1'b0;
				write_enable <= 1'b0;
				done <= 1'b0;
				access_type = 1'b0;
			end
			Wait1: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b1;
				start_wait3 <= 1'b0;
				load_registers <= 1'b1;
				write_enable <= 1'b0;
				done <= 1'b0;
				access_type = 1'b0;
			end
			Buffer_2: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait3 <= 1'b0;
				load_registers <= 1'b0;
				write_enable <= 1'b0;
				done <= 1'b0;
				access_type = 1'b0;
			end
			Write_data: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait3 <= 1'b1;
				load_registers <= 1'b0;
				write_enable <= 1'b1;
				done <= 1'b0;
				access_type = 1'b0;
			end
		endcase
	end
	
	//State Register
	always @(posedge clock) begin
		if (!resetn)
			current_state <= Buffer_1;
		else
			current_state <= next_state;
	end

endmodule