# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../Mining/mine_block.v

# Load simulation using mux as the top level simulation module.
vsim mine_block

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {clock} 1 0, 0 {10 ns} -repeat 20ns
#Check Case 1
force {random_table[287:0]} 288'b100011000001111101110000010110001110010111110100101011010110001010111101000110111100010110111011110111011010000101001011101010101101010000110011111101100101110000111110001111001101110100100010000110000110101100110110011010101000010100000011010111110010111101110001110111001110100001101011 
force {enable} 1'b1
force {previous_hash} 8'b10101010
force {signature} 8'b11111111
force {amount} 8'b00000001
force {transaction_direction} 1'b0
force {resetn} 1'b0
run 800ns

force {random_table[287:0]} 288'b100011000001111101110000010110001110010111110100101011010110001010111101000110111100010110111011110111011010000101001011101010101101010000110011111101100101110000111110001111001101110100100010000110000110101100110110011010101000010100000011010111110010111101110001110111001110100001101011 
force {enable} 1'b1
force {previous_hash} 8'b10101010
force {signature} 8'b11111111
force {amount} 8'b00000001
force {transaction_direction} 1'b0
force {resetn} 1'b1
run 4000000ns
