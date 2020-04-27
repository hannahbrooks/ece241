`timescale 1ns / 1ns // `timescale time_unit/time_precision

module muxGates(SW, LEDR);
	input [9:0] SW;
   	output [9:0] LEDR;

	wire w1, w2, w3;

	v74LS04 u0(.pin1(SW[9]), .pin2(w1)); //Hex INVERTER
	v74LS08 u1(.pin1(SW[9]), .pin2(SW[1]), .pin3(w2)); //Quad 2-input AND
	v74LS08 u2(.pin4(w1), .pin5(SW[0]), .pin6(w3)); //Quad 2-input AND
	v74LS32 u3(.pin1(w2), .pin2(w3), .pin3(LEDR[0])); //Quad 2-input OR


endmodule

module v74LS08(pin1, pin2, pin3, pin4, pin5, pin6); //AND
	input pin1, pin2, pin4, pin5;
	output pin3, pin6;
	
	assign pin3 = pin1 & pin2; 
	assign pin6 = pin4 & pin5;
	
endmodule

module v74LS32(pin1, pin2, pin3); //OR
	input pin1, pin2;
	output pin3;
	
	assign pin3 = pin1 | pin2;

endmodule

module v74LS04(pin1, pin2); //NOT
	input pin1;
	output pin2;
	
	assign pin2 = ~pin1;

endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	

