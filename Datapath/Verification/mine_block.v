`include "../../Hash/pearson_hash64.v"

module mine_block(clock, resetn, enable, previous_hash, signature, amount, transaction_direction, random_table, done_mining, new_block);
	input clock, resetn, enable;
	input [7:0] previous_hash; //Previous block hash
	input [7:0] signature; //Digital signature from player
	input [7:0] amount; //Amount of the transaction
	input transaction_direction; //0-> p1 pays p2. 1-> p2 pays p1.
	input [287:0] random_table; //LFSR table
	
	output done_mining;
	output reg[7:0] new_block;
	
	//This 39 bit value will change until we succesfully hash 
	reg [38:0] proof_of_work;
	
	//In case no correct hashes can be generated with random_table, finish mining after a long amount of work
	reg [30:0] backup_counter; 
	reg [3:0] hash_check;
	
	
	//The 64 bit message to hash
	wire [63:0] message = {previous_hash, amount, signature, transaction_direction, proof_of_work};
	wire [7:0] temp_out;
	wire finished;
	
	//Reset signals for pearson hash
	wire hash_reset;	
	reg hash_reset_reg;
	
	
	//Buffer signals for reset
	reg [2:0] reset_wait;
	wire enable_count;
	
	
	pearson_hash64 ph(.clock(clock), .message(message), .reset_n(!hash_reset), .random_table(random_table), .hash(temp_out), .finished(finished), .enable(1'b1));
	
	
	
	//Block for proof of work 
	always @(posedge clock) begin
		if (!resetn) begin
			backup_counter <= 30'b0;
			proof_of_work <= 39'b0;
			hash_check <= 4'b1111;
			hash_reset_reg <= 1'b1;
		end
		else begin
			if (enable && (backup_counter != {30{1'b1}})  && (hash_check != 4'b0)) begin
				
				//Finished hashing 
				if (finished) begin
					hash_check <= temp_out[7:4];
					proof_of_work <= proof_of_work + 1'b1;
					backup_counter <= backup_counter + 1'b1;
					hash_reset_reg <= 1'b1;
				end	
				
				//Buffer time finished, begin hashing
				if (reset_wait == 3'b111) begin
					hash_reset_reg <= 1'b0;
				end
			end
		end
	end

	//Block for reset signal manipulation
	always @(negedge clock) begin
		if (!resetn) begin
			reset_wait <= 3'b0;
		end
		else begin
			if (reset_wait == 3'b111) begin
				reset_wait <= 3'b0;
			end	
			if (enable_count && (backup_counter != {30{1'b1}})  && (hash_check != 4'b0)) begin
				reset_wait <= reset_wait + 1'b1;
			end
		end
	end
	
	//Block for ouput hash
	always @(done_mining, resetn) begin
		if (!resetn) begin
			new_block <= 8'b0;
		end
		if (done_mining) begin
			new_block <= temp_out;
		end
	end
	assign hash_reset = hash_reset_reg;
	assign enable_count = hash_reset_reg;
	assign done_mining = ((backup_counter == {30{1'b1}})  || (hash_check == 4'b0)) ? 1'b1 : 1'b0;
endmodule
