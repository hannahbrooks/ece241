module lab5_part1 (SW, KEY, HEX0, HEX1);
	input [1:0] SW;
	input [0:0] KEY;
	output [6:0] HEX0, HEX1;
	
	wire [7:0] currentQ;
	
	eightBitCounter u(.enable(SW[1]), .clock(~KEY[0]), .clear(SW[0]), .Q(currentQ));
	
	hexDisplay u1(.in(currentQ[3:0]), .HEX(HEX0));
	hexDisplay u2(.in(currentQ[7:4]), .HEX(HEX1));
	

endmodule


module eightBitCounter(enable, clock, clear, Q);
	input enable, clock, clear;
	output [7:0] Q;
	wire [7:0] w;

	tFlipflop t0(.T(enable), .clock(clock), .clear(clear), .Q(Q[0]), .Qplus1(w[1]));
	tFlipflop t1(.T(w[1]), .clock(clock), .clear(clear), .Q(Q[1]), .Qplus1(w[2]));
	tFlipflop t2(.T(w[2]), .clock(clock), .clear(clear), .Q(Q[2]), .Qplus1(w[3]));
	tFlipflop t3(.T(w[3]), .clock(clock), .clear(clear), .Q(Q[3]), .Qplus1(w[4]));
	tFlipflop t4(.T(w[4]), .clock(clock), .clear(clear), .Q(Q[4]), .Qplus1(w[5]));
	tFlipflop t5(.T(w[5]), .clock(clock), .clear(clear), .Q(Q[5]), .Qplus1(w[6]));
	tFlipflop t6(.T(w[6]), .clock(clock), .clear(clear), .Q(Q[6]), .Qplus1(w[7]));
	tFlipflop t7(.T(w[7]), .clock(clock), .clear(clear), .Q(Q[7]), .Qplus1(w[0]));

endmodule


module tFlipflop(T, clock, clear, Q, Qplus1);
	input T, clock, clear;
	output reg Q, Qplus1;

	always @(posedge clock, negedge clear)
	begin
		if (clear == 1'b0)
			Q <= 1'b0; // active low, reset to 0
		else if (T == 1'b0)
			Q <= Q; // if toggle is 0, hold state
		else
			Q <= ~Q; // if toggle is 1, change state
			
		Qplus1 = Q & T; // get T for the next flip flop
	end

endmodule


module hexDisplay(in,HEX);
   input [3:0] in;
	output [6:0] HEX; 
  
	assign HEX[0] = (~in[3]&~in[2]&~in[1]&in[0]) | (~in[3]&in[2]&~in[1]&~in[0]) | (in[3]&~in[2]&in[1]&in[0]) | (in[3]&in[2]&~in[1]&in[0]);
	assign HEX[1] = (~in[3]&in[2]&in[1]&~in[0]) | (~in[3]&in[2]&~in[1]&in[0]) | (in[3]&in[2]&~in[1]&~in[0]) | (in[3]&in[2]&in[1]&~in[0])| (in[3]&in[2]&in[1]&in[0]) | (in[3]&~in[2]&in[1]&in[0]); 
	assign HEX[2] = (~in[3]&~in[2]&in[1]&~in[0]) | (in[3]&in[2]&~in[1]&~in[0]) | (in[3]&in[2]&in[1]&~in[0]) | (in[3]&in[2]&in[1]&in[0]); 
	assign HEX[3] = (~in[3]&~in[2]&~in[1]&in[0]) | (~in[3]&in[2]&~in[1]&~in[0]) | (~in[3]&in[2]&in[1]&in[0]) | (in[3]&~in[2]&in[1]&~in[0]) | (in[3]&in[2]&in[1]&in[0]); 
	assign HEX[4] = (~in[3]&~in[2]&~in[1]&in[0]) | (~in[3]&~in[2]&in[1]&in[0]) | (~in[3]&in[2]&~in[1]&~in[0]) | (~in[3]&in[2]&~in[1]&in[0]) | (~in[3]&in[2]&in[1]&in[0]) | (in[3]&~in[2]&~in[1]&in[0]); 
	assign HEX[5] = (~in[3]&~in[2]&~in[1]&in[0]) | (~in[3]&~in[2]&in[1]&~in[0]) | (~in[3]&~in[2]&in[1]&in[0]) | (~in[3]&in[2]&in[1]&in[0]) | (in[3]&in[2]&~in[1]&in[0]); 
	assign HEX[6] = (~in[3]&~in[2]&~in[1]&~in[0]) | (~in[3]&~in[2]&~in[1]&in[0]) | (~in[3]&in[2]&in[1]&in[0]) | (in[3]&in[2]&~in[1]&~in[0]);
endmodule