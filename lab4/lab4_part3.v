module lab4_part3(SW, LEDR, KEY);
		input [9:0] SW;
		input [3:0] KEY;
		output [9:0] LEDR;
		
		wire [7:0] w;
		wire ws;
		
		mux2to1 AS	(
			.x(w[0]),
			.y(0),
			.s(KEY[3]),
			.m(ws)
		);
		
		subCircuit s7(
			.DATA_IN(SW[7]),
			.right(w[6]),
			.left(ws),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[7])
		);
		
		subCircuit s6(
			.DATA_IN(SW[6]),
			.right(w[5]),
			.left(w[7]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[6])
		);
		
		subCircuit s5(
			.DATA_IN(SW[5]),
			.right(w[4]),
			.left(w[6]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[5])
		);
		
		subCircuit s4(
			.DATA_IN(SW[4]),
			.right(w[3]),
			.left(w[5]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[4])
		);
		
		subCircuit s3(
			.DATA_IN(SW[3]),
			.right(w[2]),
			.left(w[4]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[3])
		);
		
		subCircuit s2(
			.DATA_IN(SW[2]),
			.right(w[1]),
			.left(w[3]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[2])
		);
		
		subCircuit s1(
			.DATA_IN(SW[1]),
			.right(w[0]),
			.left(w[2]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[1])
		);
		
		subCircuit s0(
			.DATA_IN(SW[0]),
			.right(w[7]),
			.left(w[1]),
			.parallelLoadn(KEY[1]),
			.RotateRight(KEY[2]),
			.clock(KEY[0]),
			.reset(SW[9]),
			.Q(w[0])
		);
		
		assign LEDR[7:0] = w[7:0];
		
endmodule 

module mux2to1(input x, y, s, output m);
	assign m = s ? y : x;
endmodule

module flipflop(input D, input clock, resetn, output reg Q);
	always @(posedge clock)
		if(resetn)
			Q <= 0;
		else
			Q <= D;
endmodule

module subCircuit(input DATA_IN, right, left, parallelLoadn, RotateRight, clock, reset, output Q);
	wire wd,wm;

	mux2to1 m1 (
		.x(DATA_IN),
		.y(wm),
		.s(parallelLoadn),
		.m(wd)
	);
	
	mux2to1 m0 (
		.x(right),
		.y(left),
		.s(RotateRight),
		.m(wm)
	);
	
	flipflop d0 (
		.D(wd),
		.clock(clock),
		.Q(Q),
		.resetn(reset)
	
	);
endmodule