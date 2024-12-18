# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../Hash/lfsr.v

# Load simulation using mux as the top level simulation module.
vsim lfsr

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

force {enable} 1'b1
force {reset} 1'b0
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b0
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b0
run 40ns
force {enable} 1'b1
force {reset} 1'b1
force {clk} 1'b1
run 40ns
