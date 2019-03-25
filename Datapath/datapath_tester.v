`include "datapath.v"
module datapath_tester(SW, KEY, LEDR, HEX0, HEX1, HEX3, HEX4);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [5:0] HEX0, HEX1, HEX3, HEX4;
	
	wire [47:0] result_out;
	datapath data(.process(KEY[3:1]), .clock(KEY[0]), .random_table(258'b0), .memory_values(48'b0000001010000000001000000000000100100000000000000),
	.player_in(1'b0), .input_amount(SW[7:0]]), .input_key(SW[7:0]), .load_amount(SW[8]), .load_key(SW[8]), .load_player(SW[8]), .load_register(SW[8]), .resetn(1'b1), .done_step(LEDR[9]), .result_out(result_out));
	
	hex_decoder H0(
        .hex_digit(result_out[43:40]), 
        .segments(HEX0)
        );
		
	hex_decoder H1(
        .hex_digit(result_out[47:44]), 
        .segments(HEX1)
        );
	
	hex_decoder H3(
        .hex_digit(result_out[19:16]), 
        .segments(HEX3)
        );
	
	hex_decoder H4(
        .hex_digit(result_out[23:20]), 
        .segments(HEX4)
        );
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule
