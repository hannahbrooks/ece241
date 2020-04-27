# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules to working dir
vlog lab5_part3.v

# load simulation using the top level simulation module
vsim lab5_part3

# log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {KEY[0]} 1
force {KEY[1]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {CLOCK_50} 1
run 20 ns

force {KEY[0]} 0
force {KEY[1]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {CLOCK_50} 1
run 40 ns

force {KEY[0]} 0
force {KEY[1]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {CLOCK_50} 1
run 120 ns

force {KEY[0]} 0
force {KEY[1]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {CLOCK_50} 1
run 40 ns

force {KEY[0]} 0
force {KEY[1]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {CLOCK_50} 1
run 100 ns