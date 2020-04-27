module lab3_part1(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
 
 mux6to1 select(.SW(SW[9:0]), .LEDR(.LEDR[9:0]));
endmodule

module mux6to1(SW, LEDR);
	input [9:0] SW;
	output reg [9:0] LEDR;
  
 	always@(*) // declare always block
 		begin
		case (SW[9:7]) // start case statement
    			3'b000: LEDR[0] = SW[0]; // case 0
    			3'b001: LEDR[0] = SW[1]; // case 1
    			3'b010: LEDR[0] = SW[2]; // case 2
    			3'b011: LEDR[0] = SW[3]; // case 3
    			3'b100: LEDR[0] = SW[4]; // case 4
    			3'b101: LEDR[0] = SW[5]; // case 5
    			default: ; // default case
   		endcase
  		end
endmodule
