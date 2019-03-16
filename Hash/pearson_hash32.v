module pearson_hash_32(message, reset_n, random_table, hash);
	//Assume 8 bit wide sequencing
	input [31:0] message;
	input reset_n;
	output [7:0] hash;
	
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
			temp_hash <= random_table[access_point[7:0]: (access_point[7:0] + 31)];
			counter <= counter + 1;
		end
	end
	
	//Output final sequenceof bits
	assign hash = (counter == 5'b11111) ? temp_hash[7:0] : 32'b0;
endmodule