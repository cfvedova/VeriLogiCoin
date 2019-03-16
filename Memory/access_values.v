module access_values(clock, process, access_p2, access_type, data_in, wren);
	input clock;
	input [2:0] process;
	
	output access_p2, wren;
	output [1:0] access_type;
	output [7:0] data_in;
	
	always @(clock)
	begin
		if(process != 3'b000) begin
			wren = 1'b0;
			data_in = 8'b0;
			access_p2 = 1'b0;
			case (process[2:0])
				001: access_type = 2'b10; //Access net money
				010: access_type = 2'b01; //Access public key
			endcase
		end
	end
endmodule