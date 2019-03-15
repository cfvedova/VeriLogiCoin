module pearson_hash(message, reset_n, hash)
	//Assume 8 bit wide sequencing
	input [31:0] message;
	input reset_n;
	output [7:0] hash;
	
	//Random 32 bit registers
	reg[31:0] chunk_1;
	reg[31:0] chunk_2;
	reg[31:0] chunk_3;
	reg[31:0] chunk_4;
	reg[31:0] chunk_5;
	reg[31:0] chunk_6;
	reg[31:0] chunk_7;
	reg[31:0] chunk_8;
	reg [31:0] buffer_chunk;
	
	//Randomize each chunk to fixed seed
	chunk_1[21:0] = $random;
	chunk_2[21:0] = $random;
	chunk_3[21:0] = $random;
	chunk_4[21:0] = $random;
	chunk_5[21:0] = $random;
	chunk_6[21:0] = $random;
	chunk_7[21:0] = $random;
	chunk_8[21:0] = $random;
	buffer_chunk[21:0] = $random;
	
	//Zero buffers
	chunk_1[31:22] = 10'b0;
	chunk_2[31:22] = 10'b0;
	chunk_3[31:22] = 10'b0;
	chunk_4[31:22] = 10'b0;
	chunk_5[31:22] = 10'b0;
	chunk_6[31:22] = 10'b0;
	chunk_7[31:22] = 10'b0;
	chunk_8[31:22] = 10'b0;
	buffer_chunk[31:22] = 10'b0;
	
	
	//Create random 256 bit table form random chunks
	reg [287:0] random_table = {chunk_1, chunk_2, chunk_3, chunk_4, chunk_5, chunk_6, chunk_7, chunk_8, buffer_chunk};
	
	//Intialize variables for computation
	reg [31:0] temp_hash = 32'b0;
	reg [31:0] access_point;
	reg [2:0] counter = 5'b00000;
	
	//Loop over 8 bits of input
	always @(*) begin
		if (!reset_n)
			temp_hash <= 32'b0;
			access_point <= 32'b0;
			counter <= 5'b00000;
			
		else if (counter != 5'b11111) begin
			access_point <= temp_hash ^ message; 
			temp_hash <= random_table[access_point: (access_point + 31)];
			counter <= counter + 1;
		end
	end
	
	//Output final sequenceof bits
	assign hash = (counter == 5'b11111) ? temp_hash : 32'b0;
endmodule