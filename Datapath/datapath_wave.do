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
force {random_table[287:0]} 288#0
force {memory_values[47:0]} 48#000000100000001001100100000000100000001001100100
force {clock} 1'b0
force {load_amount} 1'b0
force {load_key} 1'b0
force {load_player} 1'b0
force {load_register} 1'b0
force {resetn} 1'b0
force {process[2:0]} 3'b000
force {input_amount[7:0]} 8'b00000000
force {input_key[7:0]} 8'b00000000
force {player_in} 1'b0
run 40ns
#Check Case 2
force {clock} 1'b1
force {load_amount} 1'b0
force {load_key} 1'b0
force {load_player} 1'b0
force {load_register} 1'b1
force {resetn} 1'b1
force {process[2:0]} 3'b000
force {input_amount[7:0]} 8'b00000000
force {input_key[7:0]} 8'b00000000
force {player_in} 1'b0
run 40ns

force {clock} 1'b0
force {load_amount} 1'b1
force {load_key} 1'b0
force {load_player} 1'b0
force {load_register} 1'b0
force {resetn} 1'b1
force {process[2:0]} 3'b000
force {input_amount[7:0]} 8'b00000010
force {input_key[7:0]} 8'b00000000
force {player_in} 1'b0
run 40ns

force {clock} 1'b1
force {load_amount} 1'b0
force {load_key} 1'b1
force {load_player} 1'b0
force {load_register} 1'b0
force {resetn} 1'b1
force {process[2:0]} 3'b000
force {input_amount[7:0]} 8'b00000000
force {input_key[7:0]} 8'b00000010
force {player_in} 1'b0
run 40ns

force {clock} 1'b1
force {load_amount} 1'b0
force {load_key} 1'b0
force {load_player} 1'b1
force {load_register} 1'b0
force {resetn} 1'b1
force {process[2:0]} 3'b000
force {input_amount[7:0]} 8'b00000000
force {input_key[7:0]} 8'b00000000
force {player_in} 1'b0
run 40ns

force {clock} 1'b0
force {load_amount} 1'b0
force {load_key} 1'b0
force {load_player} 1'b0
force {load_register} 1'b0
force {resetn} 1'b1
force {process[2:0]} 3'b001
force {input_amount[7:0]} 8'b00000000
force {input_key[7:0]} 8'b00000000
force {player_in} 1'b0
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b001
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b001
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b001
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b001
run 40ns

#Verify Key
force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b0
force {process[2:0]} 3'b010
run 40ns

force {clock} 1'b1
force {process[2:0]} 3'b001
run 40ns