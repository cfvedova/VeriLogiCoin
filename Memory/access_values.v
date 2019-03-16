module access_values(process, access_p2, access_type, data_in, wren);
	input [2:0] process;
	
	output access_p2, wren;
	output [1:0] access_type;
	output [7:0] data_in;
	
	always @(process)
	begin
		case (process[2:0])
			3'b001: begin
				wren = 1'b0;
				data_in = 8'b0;
				access_p2 = 1'b0;
				access_type = 2'b10; //Access net money
			end
			3'b010: begin
				wren = 1'b0;
				data_in = 8'b0;
				access_p2 = 1'b0;
				access_type = 2'b01; //Access public key
			end
		endcase
	end
endmodule