module lab3_part3(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    	input [7:0] SW;
    	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [7:0] w0, w1, w2, w3, w4, w5;
	 
	fourBitAdder case0(.A(SW[7:4]), .B(SW[3:0]), .w0(w0[7:0]));
	addition case1(.A(SW[7:4]), .B(SW[3:0]), .w1(w1[7:0]));
	XNORandNAND case2(.A(SW[7:4]), .B(SW[3:0]), .w2(w2[7:0]));
	atLeastOne case3(.A(SW[7:4]), .B(SW[3:0]), .w3(w3[7:0]));
	exactlyOne case4(.A(SW[7:4]), .B(SW[3:0]), .w4(w4[7:0]));
	significantAndComplement case5(.A(SW[7:4]), .B(SW[3:0]), .w5(w5[7:0]));
	 
	reg [7:0] ALUout;

	always @(*)
		begin
        case (KEY[2:0])
            3'b111: ALUout = w0;
            3'b001: ALUout = w1;
            3'b010: ALUout = w2;
            3'b011: ALUout = w3;
            3'b100: ALUout = w4;
            3'b101: ALUout = w5;
            default: ;
        endcase
	end
	 
	assign LEDR = ALUout;
	
	hexDisplay h0(.SW(SW[7:4]), .HEX(HEX0[6:0]));
	hexDisplay h1(.SW(3'b000), .HEX(HEX1[6:0]));
	hexDisplay h2(.SW(SW[3:0]), .HEX(HEX2[6:0]));
	hexDisplay h3(.SW(3'b000), .HEX(HEX3[6:0]));
	hexDisplay h4(.SW(ALUout[3:0]), .HEX(HEX4[6:0]));
	hexDisplay h5(.SW(ALUout[7:4]), .HEX(HEX5[6:0]));
endmodule

module hexDisplay(SW, HEX);
	input [3:0]SW;
	output [6:0]HEX;

	assign c3 = SW[3];
	assign c2 = SW[2];
	assign c1 = SW[1];
	assign c0 = SW[0];

	assign HEX[0] = (~c3|~c2|~c1|c0) & (~c3|c2|~c1|~c0) & (c3|~c2|c1|c0) & (c3|c2|~c1|c0);
	assign HEX[1] = (~c3|c2|~c1|c0) & (~c3|c2|c1|~c0) & (c3|~c2|c1|c0) & (c3|c2|~c1|~c0) & (c3|c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX[2] = (~c3|~c2|c1|~c0) & (c3|c2|~c1|~c0) & (c3|c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX[3] = (~c3|~c2|~c1|c0) & (~c3|c2|~c1|~c0) & (~c3|c2|c1|c0) & (c3|~c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX[4] = (~c3|~c2|~c1|c0) & (~c3|~c2|c1|~c0) & (~c1|c2|~c3|~c0) & (~c1|c2|~c3|c0) & (~c3|c2|c1|c0) & (c3|~c2|~c1|~c0);
	assign HEX[5] = (~c3|~c2|~c1|c0) & (~c3|~c2|c1|~c0) & (~c3|~c2|c1|~c0) & (~c3|c2|c1|c0) & (c3|c2|~c1|c0);
	assign HEX[6] = (~c3|~c2|~c1|~c0) & (~c3|~c2|~c1|c0) & (~c3|c2|c1|c0) & (c3|c2|~c1|~c0);
  
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
