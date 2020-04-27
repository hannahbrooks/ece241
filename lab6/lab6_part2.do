# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab6_part2.v

#load simulation using mux as the top level simulation module
vsim lab6_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force CLOCK_50 0 0, 1 25 -repeat 50

# reset
force {KEY[0]} 0
run 10ns
force {KEY[0]} 1
run 10ns

# load a as 7
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
run 10ns

force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns

# load b as 4
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
run 10ns

force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns

# load c as 3
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
run 10ns

force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 10ns

# load x as 2
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
run 10ns

force {KEY[1]} 0
run 10ns
force {KEY[1]} 1
run 40ns


