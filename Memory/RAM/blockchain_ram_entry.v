`include "blockchain_ram.v"

module blockchain(currently_hashing, wren, message, clock, resetn, output_message);
	input [63:0] message;
	input wren, clock, currently_hashing, resetn;
	output [63:0] output_message;
	
	reg [2:0] address;
	
	blockchain_ram blkchain_ram(.address(address), .clock(clock), .data(message), .wren(wren), .q(output_message));
	
	always @(posedge currently_hashing, negedge resetn)
	begin
		if (resetn == 1'b0) begin
			address <= 3'b0;
		end
		else begin
			address <= address + 1'b1;
		end
	end
endmodule