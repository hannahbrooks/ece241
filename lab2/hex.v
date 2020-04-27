`timescale 1ns / 1ns // `timescale time_unit/time_precision

module hex(SW, HEX0); //module name and port list
	input [9:0]SW;
	output [6:0]HEX0;

	assign c3 = SW[3];
	assign c2 = SW[2];
	assign c1 = SW[1];
	assign c0 = SW[0];

	assign HEX0[0] = (~c3|~c2|~c1|c0) & (~c3|c2|~c1|~c0) & (c3|~c2|c1|c0) & (c3|c2|~c1|c0);
	assign HEX0[1] = (~c3|c2|~c1|c0) & (~c3|c2|c1|~c0) & (c3|~c2|c1|c0) & (c3|c2|~c1|~c0) & (c3|c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX0[2] = (~c3|~c2|c1|~c0) & (c3|c2|~c1|~c0) & (c3|c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX0[3] = (~c3|~c2|~c1|c0) & (~c3|c2|~c1|~c0) & (~c3|c2|c1|c0) & (c3|~c2|c1|~c0) & (c3|c2|c1|c0);
	assign HEX0[4] = (~c3|~c2|~c1|c0) & (~c3|~c2|c1|~c0) & (~c1|c2|~c3|~c0) & (~c1|c2|~c3|c0) & (~c3|c2|c1|c0) & (c3|~c2|~c1|~c0);
	assign HEX0[5] = (~c3|~c2|~c1|c0) & (~c3|~c2|c1|~c0) & (~c3|~c2|c1|~c0) & (~c3|c2|c1|c0) & (c3|c2|~c1|c0);
	assign HEX0[6] = (~c3|~c2|~c1|~c0) & (~c3|~c2|~c1|c0) & (~c3|c2|c1|c0) & (c3|c2|~c1|~c0);
  
endmodule