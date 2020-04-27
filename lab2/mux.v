`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module mux(LEDR, SW); //module name and port list
    input [9:0] SW;
    output [9:0] LEDR;

    mux2to1 u0(
        .x(SW[0]),	//assign port SW[0] to port x
        .y(SW[1]),	//assign port SW[1] to port y
        .s(SW[9]),	//assign port SW[9] to port s
        .m(LEDR[0])	//assign port LEDR[0] to port m
        );
endmodule

module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? y : x;

endmodule
