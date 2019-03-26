# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ../Controllers/memory_control.v

# Load simulation using mux as the top level simulation module.
vsim memory_control

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#Go to init_memory
force {global_reset} 2#1
force {resetn} 2#1
force {load_memory} 2#0
force {init_memory} 2#1
force {datapath_out} 2#1
force {starting_memory} 2#0
force {process} 2#000
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

#Let init_memory end
force {init_memory} 2#0
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

#Finish the buffer
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

#Start Loading data
force {load_memory} 2#1
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

#Let load_memory end
force {load_memory} 2#0
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


#Start Writing Data
force {process} 2#100
force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

force {clock} 2#0
run 40ns

force {clock} 2#1
run 40ns

#Let load_memory end
force {process} 2#000
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

#End the last wait
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