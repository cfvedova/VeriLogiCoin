module memory_control(clock, global_reset, resetn, load_memory, starting_memory, mining_hash, init_memory, done_mining, datapath_out, process, write_enable, access_type, load_registers, data_in, done_hash_store, done_memory_store, finished_init, load_previous_hash, enable_mining);
	input clock, global_reset, resetn, load_memory, init_memory, done_mining;
	input [47:0] datapath_out;
	input [2:0] process;
	input [47:0] starting_memory;
	input [7:0] mining_hash;
	
	output reg write_enable, load_previous_hash, access_type, load_registers, enable_mining, done_hash_store, done_memory_store, finished_init;
	output reg [47:0] data_in;
	
	reg [3:0] current_state;
	reg [3:0] next_state;
	
	//States
	localparam 	Init_memory = 4'b0000,
				Init_memory_Buffer = 4'b0001,
				Buffer_1 = 4'b0010,
				Load_data = 4'b0011,
				Wait1 = 4'b0100,
				Buffer_2 = 4'b0101,
				Get_prev_hash = 4'b0110,
				Start_Hashing = 4'b0111,
				Write_new_hash = 4'b1000,
				Buffer_3 = 4'b1001,
				Write_data = 4'b1010;
	
	//Wait signals to give buffer time to memory access
	reg start_wait;
	reg start_wait1;
	reg start_wait2;
	reg start_wait_write_hash;
	reg [3:0] waited;
	reg [2:0] waited_1;
	reg [2:0] waited_2;
	reg [9:0] waited_write_hash;
	
	always @(posedge clock) begin
		if (!resetn || !start_wait) begin
			waited <= 4'b0;
		end
		if (!resetn || !start_wait1) begin
			waited_1 <= 3'b0;
		end
		if (!resetn || !start_wait2) begin
			waited_2 <= 3'b0;
		end
		if (!resetn || !start_wait_write_hash) begin
			waited_write_hash <= 10'b0;
		end
		if (resetn) begin
			if (!global_reset) begin
				waited <= 4'b0;
			end 
			if (start_wait && waited != 4'b1111) begin
				waited <= waited + 1'b1;
			end
			if (start_wait1 && waited_1 != 3'b111) begin
			waited_1 <= waited_1 + 1'b1;
			end
			if (start_wait2 && waited_2 != 3'b111) begin
			waited_2 <= waited_2 + 1'b1;
			end
			if (start_wait_write_hash && waited_write_hash != 10'b1111111111) begin
			waited_write_hash <= waited_write_hash + 1'b1;
			end
		end		
	end
	
	// State Table
	always @* begin
		case (current_state)
			Init_memory: begin
				if (waited == 4'b1111) next_state = Init_memory_Buffer;
				else next_state = Init_memory;
			end
			Init_memory_Buffer: begin //This state allows the main controller to switch states so as to stop a race condition between finished_init and init_memory
				if (waited_2 == 3'b111) next_state = Buffer_1;
				else next_state = Init_memory_Buffer;
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
                   if(process == 3'b011) next_state = Get_prev_hash;
                   else next_state = Buffer_2;
		    end
			Get_prev_hash: begin
					if(waited_2 == 3'b111) next_state = Start_Hashing;
					else next_state = Get_prev_hash;
			end
			Start_Hashing: begin
				if(done_mining) next_state = Write_new_hash;
				else next_state = Start_Hashing;
			end
			Write_new_hash: begin
					if(waited_write_hash == 10'b1111111111) next_state = Buffer_3;
					else next_state = Write_new_hash;
			end
			Buffer_3: begin
				if(process == 3'b100) next_state = Write_data;
				else next_state = Buffer_3;
			end
            Write_data: begin
                   if(waited_2 == 3'b111) next_state = Buffer_1;
                   else next_state = Write_data;
		    end
          default: next_state = Buffer_1;
        endcase
	end
	
	// Output Logic
	always @(*) begin
		start_wait <= 1'b0;
		start_wait1 <= 1'b0;
		start_wait2 <= 1'b0;
		start_wait_write_hash <= 1'b0;
		load_registers <= 1'b0;
		load_previous_hash <= 1'b0;
		enable_mining <= 1'b0;
		write_enable <= 1'b0;
		done_hash_store <= 1'b0;
		done_memory_store <= 1'b0;
		access_type <= 1'b0;
		finished_init <= 1'b0;
		data_in <= starting_memory;
		
		case (current_state)
			Init_memory: begin
				finished_init <= 1'b0;
				start_wait <= 1'b1;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b1;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= starting_memory;
			end
			Init_memory_Buffer: begin
				finished_init <= 1'b1;
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b1;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= starting_memory;
			end
			Buffer_1: begin
				finished_init <= 1'b0;
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b1;
				access_type <= 1'b0;
				data_in <= datapath_out;
			end
			Load_data: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b1;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= datapath_out;
			end
			Wait1: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b1;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b1;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= datapath_out;
			end
			Buffer_2: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= datapath_out;
			end
			Get_prev_hash: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b1;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b1;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b1;
				data_in <= {40'b0, mining_hash};
			end
			Start_Hashing: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b1;
				write_enable <= 1'b0;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b1;
				data_in <= {40'b0, mining_hash};
			end
			Write_new_hash: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b1;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b1;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b1;
				data_in <= {40'b0, mining_hash};
			end
			Buffer_3: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b0;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b0;
				done_hash_store <= 1'b1;
				done_memory_store <= 1'b0;
				access_type <= 1'b1;
				data_in <= {40'b0, mining_hash};
			end
			Write_data: begin
				start_wait <= 1'b0;
				start_wait1 <= 1'b0;
				start_wait2 <= 1'b1;
				start_wait_write_hash <= 1'b0;
				load_registers <= 1'b0;
				load_previous_hash <= 1'b0;
				enable_mining <= 1'b0;
				write_enable <= 1'b1;
				done_hash_store <= 1'b0;
				done_memory_store <= 1'b0;
				access_type <= 1'b0;
				data_in <= datapath_out;
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