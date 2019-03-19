module complete_transaction(p1_amount, p2_amount, amount_change, clock, p1_amount_out, p2_amount_out, complete_transaction_signal);
	input [10:0] p1_amount, p2_amount;
	input [7:0] amount_change;
	input clock;
	output [10:0] p1_amount_out, p2_amount_out;
	output complete_transaction_signal;
	
	always @(clock);
	begin
		case (p2_amount[10:8])
			3'b110: begin
				p1_amount_out[7:0] = p1_amount[7:0] - amount_change;
				p1_amount_out[10:8] = p1_amount[10:8];
				p2_amount_out[7:0] = p2_amount[7:0] + amount_change;
				p2_amount_out[10:8] = p2_amount[10:8];
				complete_transaction_signal = 1'b1;
			end
			default:
				complete_transaction_signal = 1'b0;
		endcase
	end
endmodule