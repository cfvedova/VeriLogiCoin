module lfsr_bit(data, clk, reset);
	output [31:0] data;
	input clk, reset;
	reg [31:0] data_next;
	
	//Initialize polynomial function for 32 bits
	wire feedback = data[31] ^ data[29] ^ data[25] ^ data[24]; 
	
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			data_next <= 31'hFFFFFFFF; //An LFSR cannot have an all 0 state, thus reset to all 1's
		else
			data_next <= {data_next[30:0], feedback}; //shift left the xor'd every posedge clock
	end

	assign data = data_next;	
endmodule

module lfsr(random_sequence, clk, reset, done_creating_sequence);
	output [255:0] random_sequence;
	output done_creating_sequence;
	input clk, reset;
	
	//Connect to random bit initializer	
	wire [31:0] seq;
	wire rand_bit = seq[0];
	lfsr_bit lfsr_bit(.data(seq), .clk(clk), .reset(reset));
	
	
	//Sample 256 clock cycles, with a new random bit every clock cycle
	reg [255:0] generated_seq = 8'b0;
	reg [6:0] counter = 7'b1111111;
	always @(posedge clk)
	begin
		if (reset)
			counter <= 7'b1111111;
		else 
			if (counter != 7'b0000000)
				generated_seq <= {generated_seq[254:0], rand_bit};
				counter <= counter - 1'b1;
	end
	assign done_creating_sequence = (counter == 0) ? 1 : 0;
	assign random_sequence = (counter == 0) ? generated_seq : 8'b0;
	
endmodule