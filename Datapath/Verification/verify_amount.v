module verify_amount(player_money, amount, clock, correct);
	input [10:0] player_money;
	input [7:0] amount;
	input clock;
	
	output reg correct;
	
	always @(clock)
	begin
		case (player_money[10:8])
			3'b001:
				correct <= player_money[7:0] >= amount;
			default:
				correct <= 1'b0;
		endcase
	end
endmodule