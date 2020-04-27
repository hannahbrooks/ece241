module lab3_part2(SW, LEDR);
 input [9:0] SW;
 output [9:0] LEDR;

 fourBitAdder add(.A(SW[7:4]), .B(SW[3:0]), .C_carry(SW[8]), .C_out(LEDR[9]), .S(LEDR[3:0]));

endmodule

module fourBitAdder(A, B, C_carry, C_out, S);
 input [3:0] A;
 input [3:0] B;
 input C_carry;
 output C_out;
 output [3:0] S;
 
 wire w1, w2, w3;
 
 full_adder add_1(.A(A[0]), .B(B[0]), .C_carry(C_carry), .C_out(w1), .S(S[0]));
 full_adder add_2(.A(A[1]), .B(B[1]), .C_carry(w1), .C_out(w2), .S(S[1]));
 full_adder add_3(.A(A[2]), .B(B[2]), .C_carry(w2), .C_out(w3), .S(S[2]));
 full_adder add_4(.A(A[3]), .B(B[3]), .C_carry(w3), .C_out(C_out), .S(S[3]));
endmodule

module full_adder(A, B, C_carry, C_out, S);
 input A, B, C_carry;
 output C_out, S;
 
 assign C_out = (A^B) ? C_carry : B; 
 assign S = A^B^C_carry;
endmodule
