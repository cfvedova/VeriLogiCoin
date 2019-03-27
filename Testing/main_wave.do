# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../main.v

# Load simulation using mux as the top level simulation module.
vsim main

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#Check Case 1
force {SW} 2#0
force {KEY} 2#1111
force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {KEY[1]} 2#0
force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {KEY[1]} 2#1
force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns

force {CLOCK_50} 2#0
run 40ns

force {CLOCK_50} 2#1
run 40ns