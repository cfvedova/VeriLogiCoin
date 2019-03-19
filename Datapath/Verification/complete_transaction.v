module complete_transaction(process, p1_amount, p2_amount, amount_change, clock, p1_amount_out, p2_amount_out, complete_transaction_signal);
	input [2:0] process;
	input [7:0] p1_amount, p2_amount;
	input [7:0] amount_change;
	input clock;
	
	output reg [7:0] p1_amount_out, p2_amount_out;
	output reg complete_transaction_signal;
	
	always @(clock)
	begin
		p1_amount_out[7:0] <= p1_amount[7:0] - amount_change;
		p2_amount_out[7:0] <= p2_amount[7:0] + amount_change;
	end
endmodule