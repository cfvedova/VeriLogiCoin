# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../Controllers/transaction_control.v

# Load simulation using mux as the top level simulation module.
vsim transaction_control

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#Go to init_memory
force {resetn} 2#1
force {start_transaction} 2#0
force {done_travel} 2#1
force {done_step} 2#0
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {start_transaction} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {start_transaction} 2#0
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

#Finish step 1
force {done_step} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {done_step} 2#0
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

#Finish step 2
force {done_step} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {done_step} 2#0
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

#Finish Step 3
force {done_step} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {done_step} 2#0
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

#Finish Step 4
force {done_step} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {done_step} 2#0
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns
