# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns datapath.v

# Load simulation using mux as the top level simulation module.
vsim datapath

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#Check Case 1
force {random_table[287:0]} 2#0
force {memory_values[47:0]} 2#000000100000000001100100000000100000000001100100
force {clock} 2#0
force {load_amount} 2#0
force {load_key} 2#0
force {load_player} 2#0
force {load_register} 2#0
force {resetn} 2#0
force {process[2:0]} 2#000
force {input_amount[7:0]} 2#00000000
force {input_key[7:0]} 2#00000000
force {player_in} 2#0
run 40ns
#Check Case 2
force {clock} 2#1
force {load_amount} 2#0
force {load_key} 2#0
force {load_player} 2#0
force {load_register} 2#1
force {resetn} 2#1
force {process[2:0]} 2#000
force {input_amount[7:0]} 2#00000000
force {input_key[7:0]} 2#00000000
force {player_in} 2#0
run 40ns

force {clock} 2#0
force {load_amount} 2#1
force {load_key} 2#0
force {load_player} 2#0
force {load_register} 2#0
force {resetn} 2#1
force {process[2:0]} 2#000
force {input_amount[7:0]} 2#00000010
force {input_key[7:0]} 2#00000000
force {player_in} 2#0
run 40ns

force {clock} 2#1
force {load_amount} 2#0
force {load_key} 2#1
force {load_player} 2#0
force {load_register} 2#0
force {resetn} 2#1
force {process[2:0]} 2#000
force {input_amount[7:0]} 2#00000000
force {input_key[7:0]} 2#00000010
force {player_in} 2#0
run 40ns

force {clock} 2#1
force {load_amount} 2#0
force {load_key} 2#0
force {load_player} 2#1
force {load_register} 2#0
force {resetn} 2#1
force {process[2:0]} 2#000
force {input_amount[7:0]} 2#00000000
force {input_key[7:0]} 2#00000000
force {player_in} 2#0
run 40ns

force {clock} 2#0
force {load_amount} 2#0
force {load_key} 2#0
force {load_player} 2#0
force {load_register} 2#0
force {resetn} 2#1
force {process[2:0]} 2#001
force {input_amount[7:0]} 2#00000000
force {input_key[7:0]} 2#00000000
force {player_in} 2#0
run 40ns

force {clock} 2#0
force {process[2:0]} 2#001
run 40ns

force {clock} 2#1
force {process[2:0]} 2#001
run 40ns

force {clock} 2#0
force {process[2:0]} 2#001
run 40ns

force {clock} 2#1
force {process[2:0]} 2#001
run 40ns

#Verify Key
force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {memory_values[47:0]} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns

force {clock} 2#0
force {process[2:0]} 2#010
run 40ns

force {clock} 2#1
force {process[2:0]} 2#010
run 40ns