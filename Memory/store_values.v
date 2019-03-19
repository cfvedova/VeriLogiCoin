module store_values(message, access_p2_out, access_type_out, data_out, wren);
	input [10:0] message;
	
	output access_p2_out, wren;
	output [1:0] access_type_out;
	output [7:0] data_out;
	
	always @(message)
	begin
		case(message[10:8])
			3'b101: begin
				access_p2_out = 1'b0;
				access_type_out = 2'b10;
				wren = 1'b1;
				data_out = message[7:0];
			end
			3'b110: begin
				access_p2_out = 1'b1;
				access_type_out = 2'b10;
				wren = 1'b1;
				data_out = message[7:0];
			end
		endcase
	end
endmodule