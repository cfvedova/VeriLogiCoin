module pearson_hash(message, hash, reset_n)
	//Assume 8 bit wide sequencing
	output [7:0] hash;
	input [7:0] message;
	input reset_n;
	
	//Random 32 bit registers
	reg[31:0] chunk_1;
	reg[31:0] chunk_2;
	reg[31:0] chunk_3;
	reg[31:0] chunk_4;
	reg[31:0] chunk_5;
	reg[31:0] chunk_6;
	reg[31:0] chunk_7;
	reg[31:0] chunk_8;
	
	//Randomize each chunk to fixed seed
	chunk_1 = $random;
	chunk_2 = $random;
	chunk_3 = $random;
	chunk_4 = $random;
	chunk_5 = $random;
	chunk_6 = $random;
	chunk_7 = $random;
	chunk_8 = $random;
	buffer_chunk = $random;
	
	//Create random 256 bit table form random chunks
	reg [287:0] random_table = {chunk_1, chunk_2, chunk_3, chunk_4, chunk_5, chunk_6, chunk_7, chunk_8, buffer_chunk};
	
	//Intialize variables for computation
	reg [7:0] temp_hash = 8'b00000000;
	reg [7:0] access_point;
	reg [2:0] counter = 3'b000;
	
	//Loop over 8 bits of input
	always @(*) begin
		if (!reset_n)
			temp_hash <= 8'b00000000;
			access_point <= 8'b00000000;
			counter <= 3'b000;
			
		else if (counter != 3'b111) begin
			access_point <= temp_hash ^ message; 
			temp_hash <= random_table[access_point: (access_point + 8)];
			counter <= counter + 1'b0;
		end
	end
	
	//Output final sequenceof bits
	assign hash = (counter == 3'b111) ? temp_hash : 8'b00000000;
endmodule