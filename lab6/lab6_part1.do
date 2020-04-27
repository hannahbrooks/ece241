# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab_part1.v

#load simulation using mux as the top level simulation module
vsim lab6_part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# nothing should happen reset is low
force {SW[0]} 0
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# running 1111
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# running 1101
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns

force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {SW[1]} 0
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {SW[1]} 1
force {KEY[0]} 1
run 10ns

# overlap 111011
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns

force {SW[1]} 0
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
force {KEY[0]} 0
run 10ns

