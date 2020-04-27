# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab4_part3.v

#load simulation using mux as the top level simulation module
vsim lab4_part3

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#test cases
#set the clock to switch up and down
force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

#reset register
force {SW[7:0]} 8'b00000000
force {SW[9]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

#load in a number
force {SW[7:0]} 8'b1001110
force {SW[9]} 0
force {KEY[1]} 0
run 10ns

#rotate the number left 3x
force {KEY[1]} 1
run 30ns

#rotate the number right 3x
force {KEY[2]} 1
run 30ns

#rotate the number right with logical shift
force {KEY[3]} 1
run 30ns

#rotate the number left with logical shift
force {KEY[2]} 0
run 50ns

#reset the register
force {SW[9]} 1
run 10ns