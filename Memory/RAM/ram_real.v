module ram(clock, access_type, data_in, wren, result, resetn);
	input clock, resetn;
	input [0:0] access_type; //0: player values, 1: blockchain
	input [47:0] data_in;
	input wren; //Write or read
	output reg [47:0] result;
	
	
	always @(posedge clock) begin
		if (!resetn)
			result <= 48'b0;
		if (wren) begin
			result <= data_in;
		end
	end
endmodule