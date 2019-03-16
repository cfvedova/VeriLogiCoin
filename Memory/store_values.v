module access_values(process, access_p2_out, access_type_out, data_out, wren);
	input [2:0] process;
	
	output access_p2_out, wren;
	output [1:0] access_type_out;
	output [7:0] data_out;
	
	if(process == 3'b100) begin
		wren = 1'b1;
		
	end
endmodule