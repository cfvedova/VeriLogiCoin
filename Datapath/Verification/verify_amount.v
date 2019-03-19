module verify_amount(player_money, amount, clock, correct);
	input [7:0] player_money;
	input [7:0] amount;
	input clock;
	
	output reg correct;
	
	always @(clock)
	begin
		case (player_money)
			8'b0:
				correct <= 2'b0;
			default:
				correct <=  player_money >= amount;
		endcase
	end
endmodule