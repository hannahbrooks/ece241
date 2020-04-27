

module lab4_part2(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
   input [9:0] SW;
   input [2:0] KEY;
   output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [7:0] w0, w1, w2, w3, w4, w5, w6;
  
	fourBitAdder case0(.A(SW[7:4]), .B(SW[3:0]), .w0(w0[7:0]));
	addition case1(.A(SW[7:4]), .B(SW[3:0]), .w1(w1[7:0]));
	XNORandNAND case2(.A(SW[7:4]), .B(SW[3:0]), .w2(w2[7:0]));
	atLeastOne case3(.A(SW[7:4]), .B(SW[3:0]), .w3(w3[7:0]));
	exactlyOne case4(.A(SW[7:4]), .B(SW[3:0]), .w4(w4[7:0]));
	significantAndComplement case5(.A(SW[7:4]), .B(SW[3:0]), .w5(w5[7:0]));
	register case6(.D(SW[3:0]), .clk(KEY[0]), .reset(SW[9]), .Q(w6));
	
	reg [7:0] ALUout;
	always @(*)
	begin
		case (KEY[2:0])
			3'b111: ALUout = w0;
			3'b110: ALUout = w1;
			3'b101: ALUout = w2;
			3'b100: ALUout = w3;
			3'b011: ALUout = w4;
			3'b010: ALUout = w5;
			3'b001: ALUout = w6;
			default: ;
		endcase
	end
  
	assign LEDR = ALUout;
	
	hexDisplay h0(.in(SW[3:0]), .HEX(HEX0[6:0]));
	hexDisplay h1(.in(3'b000), .HEX(HEX1[6:0]));
	hexDisplay h2(.in(SW[7:4]), .HEX(HEX2[6:0]));
	hexDisplay h3(.in(3'b000), .HEX(HEX3[6:0]));
	hexDisplay h4(.in(ALUout[3:0]), .HEX(HEX4[6:0]));
	hexDisplay h5(.in(ALUout[7:4]), .HEX(HEX5[6:0]));
endmodule

module register(D, clk, reset, Q);
	input [3:0] D;
	input clk, reset;
	output reg [3:0] Q;

	always @(posedge clk)
	begin
	if (reset == 1'b0)
		Q<=0; // assign q = 0
	else
		Q<=D; // assign q = d
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

module significantAndComplement(A, B, w5);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w5;

	assign w5[7:4] = A;
	assign w5[3:0] = ~B;
endmodule

module exactlyOne(A, B, w4);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w4;

	assign w4 = ((A == (A & ~A)) && ((B == 3) | (B == 5) | (B == 6) | (B == 9) | (B == 10) | (B == 12))) ? 8'b1110000 : 8'b0000_0000;
endmodule

module atLeastOne(A, B, w3);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w3;

	assign w3 = ((A>0) | (B>0)) ? (8'b000_1111) : (8'b0000_0000);
endmodule

module XNORandNAND(A, B, w2);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w2;

	assign w2[7:4] = ~(A^B);
	assign w2[3:0] = ~(A&B); 
endmodule

module addition(A, B, w1);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w1;

	assign w1 = (A+B);
endmodule

module fourBitAdder(A, B, w0);
	input [3:0] A;
	input [3:0] B;
	output [7:0] w0;

	wire w1, w2, w3;

	full_adder add_1(.A(A[0]), .B(B[0]), .C_carry(1'b0), .C_out(w1), .S(w0[0]));
	full_adder add_2(.A(A[1]), .B(B[1]), .C_carry(w1), .C_out(w2), .S(w0[1]));
	full_adder add_3(.A(A[2]), .B(B[2]), .C_carry(w2), .C_out(w3), .S(w0[2]));
	full_adder add_4(.A(A[3]), .B(B[3]), .C_carry(w3), .C_out(w0[4]), .S(w0[3]));
endmodule

module full_adder(A, B, C_carry, C_out, S);
	input A, B, C_carry;
	output C_out, S;

	assign C_out = (A^B) ? C_carry : B; 
	assign S = A^B^C_carry;
endmodule
