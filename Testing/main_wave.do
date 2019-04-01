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

force {CLOCK_50} 1 0, 0 {10 ns} -repeat 20ns
#Check Case 1
force {SW} 2#0
force {KEY} 2#1011
run 800ns

force {KEY[2]} 2#1
run 800ns

#INIT MEMORY
force {KEY[0]} 2#0
run 800ns

force {KEY[0]} 2#1
run 10000ns

force {SW[7:0]} 2#00000100
run 20ns

#LOAD AMOUNT
force {KEY[1]} 2#0
run 800ns

force {KEY[1]} 2#1
run 800ns

force {SW[7:0]} 2#01110101
run 20ns

#LOAD KEY
force {KEY[1]} 2#0
run 800ns

force {KEY[1]} 2#1
run 800ns

force {SW[7:0]} 2#0
run 20ns

#START TRANSACTION
force {KEY[0]} 2#0
run 800ns

force {KEY[0]} 2#1
run 800ns

run 50000ns