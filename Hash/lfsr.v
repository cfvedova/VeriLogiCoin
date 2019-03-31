module lfsr_bit(data, clk, reset);
	output [31:0] data;
	input clk, reset;
	reg [31:0] data_next;
	
	//Initialize polynomial function for 32 bits
	wire feedback = data_next[31] ^ data_next[29] ^ data_next[25] ^ data_next[2]; 
	
	always @ (posedge clk)
	begin
		if (!reset)
			data_next <= 32'h60BCd9BE ; //An LFSR cannot have an all 0 state
		else
			data_next <= {data_next[30:0], feedback}; //shift left the xor'd every posedge clockgit 
	end

	assign data = data_next;	
endmodule

module lfsr(random_sequence, clk, reset, done_creating_sequence, enable);
	output [287:0] random_sequence;
	output done_creating_sequence;
	input clk, reset, enable;
	
	//Connect to random bit initializer	
	wire [31:0] seq;
	wire rand_bit = seq[0];
	lfsr_bit lfsr_bit(.data(seq), .clk(clk), .reset(reset));
	
	
	//Sample 256 clock cycles, with a new random bit every clock cycle

	reg [255:0] generated_seq;
	reg [8:0] counter;
	always @(posedge clk)
	begin
		if (!reset) begin
			counter <= 9'b111111111;
			generated_seq <= 256'b0;
		end
		else 
			if (enable) begin
				if (counter != 9'b000000000) begin
					generated_seq <= {generated_seq[254:0], rand_bit};
					counter <= counter - 1'b1;
				end
			end
	end
	assign done_creating_sequence = (counter == 0) ? 1'b1 : 1'b0;
	assign random_sequence = (counter == 0) ? {generated_seq, 32'b0} : 288'b0;
	
endmodule