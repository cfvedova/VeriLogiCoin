module access_values(process, second_player, protocol, access_p2, access_type, data_in, wren);
	input [2:0] process;
	input [1:0] second_player;
	
	output reg [2:0] protocol;
	output reg access_p2, wren;
	output reg [1:0] access_type;
	output reg [7:0] data_in;
	
	always @(process, second_player)
	begin
		case (process[2:0])
			3'b001: begin
				wren <= 1'b0;
				data_in <= 8'b0;
				access_p2 <= 1'b0;
				access_type <= 2'b10; //Access net money
				protocol <= process;
			end
			3'b010: begin
				wren <= 1'b0;
				data_in <= 8'b0;
				access_p2 <= 1'b0;
				access_type <= 2'b01; //Access public key
				protocol <= process;
			end
			3'b100: begin
				case (second_player)
					01: begin
						wren <= 1'b0;
						data_in <= 8'b0;
						access_p2 <= 1'b0;
						access_type <= 2'b10;
						protocol <= 3'b101;
					end
					10: begin
						wren <= 1'b0;
						data_in <= 8'b0;
						access_p2 <= 1'b1;
						access_type <= 2'b01;
						protocol <= 3'b110;
					end
				endcase
			end
		endcase
	end
endmodule