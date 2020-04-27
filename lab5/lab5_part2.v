module lab5_part2(SW, CLOCK_50, HEX0);
	input [2:0] SW;
	input CLOCK_50;
	output [6:0] HEX0;
	
	wire [4:0] currentCount;
	
	counter u0(.sel(SW[1:0]), .clock(CLOCK_50), .reset(SW[2]), .count(currentCount));
	hexDisplay hex(.in(currentCount[3:0]), .HEX(HEX0));

	
endmodule

module counter(sel, clock, reset, count);
	input [1:0] sel;
	input clock, reset;
	output [4:0] count;
	
	wire [25:0] frequency;
	wire enable;
	
	speedMux u1(.select(sel), .maxCycles(frequency));
	rateDivider u2(.maxCycles(frequency), .clock(clock), .reset(reset), .downClock(enable));
	fourBitCounter u3(.clock(clock), .reset(reset), .enable(enable), .Q(count));
	
endmodule


module speedMux(select, maxCycles);
	input [1:0] select;
	output reg [25:0] maxCycles;
	
	always @(*)
	begin
		case(select)
			2'b00: maxCycles= 26'b0;
			2'b01: maxCycles= 26'b101111101011110000011111111; // 0.5
			2'b10: maxCycles = 26'b001011111010111100000111111; // 2
			2'b11: maxCycles= 26'b010111110101111000001111111; // 1
		endcase
	end
endmodule


module rateDivider(maxCycles, clock, reset, downClock);
	input clock, reset;
	input [25:0] maxCycles;
	output downClock;
	
	reg [25:0] cycleCount;
	
	always @(posedge clock)
	begin
		if (reset == 1'b0)
			 cycleCount <= 26'd0;
		else if (cycleCount == 26'b0)
			cycleCount <= maxCycles;
		else
			cycleCount <= cycleCount - 1'b1;
	end
	assign downClock = (cycleCount == 26'd0) ? (1'b1):(1'b0);
endmodule


module fourBitCounter(clock, reset, enable, Q);
	input clock, reset, enable;
	output reg [3:0] Q;
		
	always @(posedge clock)
	begin
		if (reset == 1'd0) // sync reset active low
		begin
			Q <= 5'd0;
		end
		else if (Q == 5'd16) // max value
		begin
			Q <= 5'd0;
		end
		else if (enable == 1'd1) // increment only when enable is on
		begin
			Q <= Q + 1;
		end
		else
		begin
			Q <= Q;
		end
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