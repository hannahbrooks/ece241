# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab3_part2.v

#load simulation using mux as the top level simulation module
vsim lab3_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
# A = 0, B = 0, C_carry = 1 --> S = 1, C_out = 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

force {SW[8]} 0
#run simulation for a few ns
run 10ns

#second test case
# A = 8, B = 8, C_carry = 0 --> S = 16, C_out = 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

force {SW[8]} 0
#run simulation for a few ns
run 10ns

#third test case
# A = 1, B = 1, C_carry = 0 --> S = 2, C_out = 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1

force {SW[8]} 0
#run simulation for a few ns
run 10ns

#fourth test case
# A = 2, B = 2, C_carry = 0 --> S = 4, C_out = 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0

force {SW[8]} 0
#run simulation for a few ns
run 10ns

#fifth test case
# A = 4, B = 4, C_carry = 0 --> S = 8, C_out = 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0

force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0

force {SW[8]} 0
#run simulation for a few ns
run 10ns

#sixth test case
# A = 15, B = 15, C_carry = 1 --> S = 15, C_out = 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1

force {SW[8]} 1
#run simulation for a few ns
run 10ns

#seventh test case
# A = 9, B = 6, C_carry = 0 --> S = 15, C_out = 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0

force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1

force {SW[8]} 0
#run simulation for a few ns
run 10ns

