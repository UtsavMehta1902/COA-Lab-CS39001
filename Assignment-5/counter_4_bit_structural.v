`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:04 09/14/2022 
// Design Name: 
// Module Name:    counter_4_bit_structural 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

/*
	* Assignment-5
	* Problem - 1
	* Semester - 5 (Autumn)
	* Group - 56
	* Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)
*/

module counter_4_bit_structural(clk100mhz, rst, counter);
	input clk100mhz, rst;
	output [3:0] counter;
	
	wire [3:0] dff_in;
	wire [3:0] dff_out;
	
	wire counter_clock;
	clock_divider cd(clk100mhz, counter_clock);
	
	add_one adder(dff_out, dff_in);
	
	d_flip_flop mod(dff_in, rst, counter_clock, dff_out);
	
	assign counter = dff_out;
	
endmodule
