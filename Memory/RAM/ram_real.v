module ram(clock, access_type, data_in, wren, result, resetn);
	input clock, resetn;
	input access_type; //0: player values, 1: blockchain
	input [47:0] data_in;
	input wren; //Write or read
	output [47:0] result;
	
	reg [47:0] transaction_data;
	reg [7:0] previous_hash;
	
	always @(posedge clock) begin
		if (!resetn) begin
			transaction_data <= 48'b0;
			previous_hash <= 8'b11111111;
		end
		else if (wren) begin
			if (access_type) begin
				previous_hash <= data_in[7:0];
			end
			else begin
				transaction_data <= data_in;
			end
		end
	end
	
	assign result = (access_type) ? {40'b0, previous_hash} : transaction_data;
endmodule