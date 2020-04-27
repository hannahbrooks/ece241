# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab5_part2.v

#load simulation
vsim lab5_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {CLOCK_50} 0 0ns , 1 {10ns} -r 20ns

force {SW[1]} 0
force {SW[0]} 0
run 1300ms

force {CLOCK_50} 0 0ns , 1 {10ns} -r 20ns

force {SW[1]} 0
force {SW[0]} 1
run 4000ms

force {CLOCK_50} 0 0ns , 1 {10ns} -r 20ns

force {SW[1]} 1
force {SW[0]} 0
run 8000ms

force {CLOCK_50} 0 0ns , 1 {10ns} -r 20ns

force {SW[1]} 1
force {SW[0]} 1
run 16000ns

