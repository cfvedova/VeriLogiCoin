module pearson_hash8(message, reset_n, random_table, hash, counter);
	//Assume 8 bit wide sequencing
	input [7:0] message;
	input reset_n;
	input [287:0] random_table;
	output [7:0] hash;
	output reg [2:0] counter = 3'b000;
	
	//Intialize variables for computation
	reg [7:0] temp_hash = 8'b0;
	reg [7:0] access_point;
	
	//Loop over 8 bits of input
	always @(*) begin
		if (!reset_n) begin
			temp_hash <= 8'b0;
			access_point <= 8'b0;
			counter <= 3'b000;
		end
		else begin
			if (counter != 3'b111) begin
				access_point <= temp_hash ^ message; 
				temp_hash[7:0] <= random_table[287:0] >> access_point[7:0];
				counter <= counter + 1;
			end
		end
	end
	
	//Output final sequence of bits
	assign hash = (counter == 3'b111) ? temp_hash : 8'b0;
endmodule