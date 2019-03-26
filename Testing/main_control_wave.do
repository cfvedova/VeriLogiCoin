# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../Controllers/main_control.v

# Load simulation using mux as the top level simulation module.
vsim main_control

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#Check Case 1
force {start_signal} 2#0
force {load_signal} 2#0
force {finished_init} 2#0
force {finished_transaction} 2#0
force {resetn} 2#1
force {done_table_init} 2#0
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {load_signal} 2#1
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {load_signal} 2#0
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {done_table_init} 2#0
force {clock} 2#0
run 40ns

force {done_table_init} 2#1
force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {done_table_init} 2#0
force {clock} 2#1
run 40ns

force {finished_init} 2#1
force {clock} 2#0
run 40ns

force {finished_init} 2#1
force {clock} 2#1
run 40ns

force {finished_init} 2#0
force {clock} 2#0
run 40ns

force {finished_init} 2#1
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

#Start loading amount
force {load_signal} 2#1
force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {load_signal} 2#0
force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

#Start loading key
force {load_signal} 2#1
force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {load_signal} 2#0
force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

#Start running the transaction
force {start_signal} 2#1
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {start_signal} 2#0
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


#End the transaction
force {finished_transaction} 2#1
force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns


force {clock} 2#1
run 40ns

force {finished_transaction} 2#0
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