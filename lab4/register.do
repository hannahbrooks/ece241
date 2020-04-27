# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab4_part2.v

#load simulation using mux as the top level simulation module
vsim register

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#test cases
#set the clock to switch up and down
force {clk} 0 0ns, 1 {5ns} -r 10ns

#reset the system
force {reset} 0
force {D[3:0]} 4'b0
run 10ns

#add numbers to the system
force {reset} 1
force {D[3:0]} 4'b0100
run 10ns

#flip numbers around (no numbers should change until 5ns passes and then they should hold)
force {D[3:0} 4'b0001
run 1ns

force {D[3:0]} 4'b0010
run 1ns

force {D[3:0]} 4'b0011
run 1ns

force {D[3:0]} 4'b0100
run 1ns

force D[3:0]} 4'b0101
run 1ns

force {D[3:0]} 4'b0110
run 1ns

force {D[3:0]} 4'b0111
run 1ns

force {D[3:0]} 4'b1000
run 1ns

force {D[3:0]} 4'b1001
run 1ns

force {D[3:0]} 4'b1010
run 1ns

#reset the system
force {reset} 0
run 10ns