module pearson_hash64(clock, message, reset_n, random_table, hash, finished, enable);
	//Assume 64 bit wide sequencing
	input [63:0] message;
	input reset_n, clock, enable;
	input [287:0] random_table;
	output [7:0] hash;
	output finished;
	
	//Intialize variables for computation
	reg [7:0] temp_hash;
	reg [7:0] access_point;
	reg [4:0] counter;
	reg enable_counter;

	//Loop over 32 bits of input
	always @(posedge clock) begin
		if (!reset_n) begin
			temp_hash <= 8'b0;
			enable_counter <= 1'b0;
		end
		else if (enable) begin						
			if (counter != 5'b11111) begin
			 enable_counter <= 1'b1;
			 case(access_point[7:3])
				0:
					temp_hash <= random_table[7:0];
				1:
					temp_hash <= random_table[16:9];
				2:
					temp_hash <= random_table[25:18];
				3:
					temp_hash <= random_table[34:27];
				4:
					temp_hash <= random_table[43:36];
				5:
					temp_hash <= random_table[52:45];
				6:
					temp_hash <= random_table[61:54];
				7:
					temp_hash <= random_table[70:63];
				8:
					temp_hash <= random_table[79:72];
				9:
					temp_hash <= random_table[88:81];
				10:
					temp_hash <= random_table[97:90];
				11:
					temp_hash <= random_table[106:99];
				12:
					temp_hash <= random_table[115:108];
				13:
					temp_hash <= random_table[124:117];
				14:
					temp_hash <= random_table[133:126];
				15:
					temp_hash <= random_table[142:135];
				16:
					temp_hash <= random_table[151:144];
				17:
					temp_hash <= random_table[161:155];
				18:
					temp_hash <= random_table[172:165];
				19:
					temp_hash <= random_table[180:173];
				20:
					temp_hash <= random_table[189:182];
				21:
					temp_hash <= random_table[198:191];
				22:
					temp_hash <= random_table[207:200];
				23:
					temp_hash <= random_table[216:209];
				24:
					temp_hash <= random_table[225:218];
				25:
					temp_hash <= random_table[234:227];
				26:
					temp_hash <= random_table[243:236];
				27:
					temp_hash <= random_table[252:245];
				28:
					temp_hash <= random_table[261:254];
				29:
					temp_hash <= random_table[270:263];
				30:
					temp_hash <= random_table[279:272];
				31:
					temp_hash <= random_table[287:280];
				default: temp_hash <= 8'b11111111;
			endcase
			end
		end
	end
	
	always @(negedge clock) begin
		if (!reset_n) begin
			access_point <= 8'b10101010;
			counter <= 5'b00000;
		end
		else if (enable_counter) begin		
			if (counter != 5'b11111) begin
				access_point <= ((temp_hash ^ message[7:0]) ^ (temp_hash ^ message[15:8]) ^ (temp_hash ^ message[23:16]) ^ (temp_hash ^ message[31:24]) ^ (temp_hash ^ message[39:32]) ^ (temp_hash ^ message[47:40]) ^ (temp_hash ^ message[55:48]) ^ (temp_hash ^ message[63:56])); 
				counter <= counter + 1'b1;	
			end
		end
	end
	assign hash = (counter == 5'b11111) ? temp_hash : 8'b11111111;
	assign finished = (counter == 5'b11111) ? 1'b1 : 1'b0;
endmodule