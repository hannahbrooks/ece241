# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab4_part2.v

#load simulation using mux as the top level simulation module
vsim lab4_part2

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#test cases
#set the clock to switch up and down
force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

#reset the register
force {SW[3:0]} 4'b0000
force {SW[9]} 0
force {KEY[2:0]} 3'b000
run 10ns

#attempt to add two numbers
force {SW[3:0]} 4'b1010
force {SW[9]} 1
force {KEY[2:0]} 3'b000
run 10ns

force {SW[3:0]} 4'b0011
force {KEY[2:0]} 3'b000
run 10ns

#attempt case 7
force {SW[3:0]} 4'b0111
force {KEY[2:0]} 3'b001
run 10ns

force {SW[3:0]} 4'b0011
force {KEY[2:0]} 3'b000
run 10ns