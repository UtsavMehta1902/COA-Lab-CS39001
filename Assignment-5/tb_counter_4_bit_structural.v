`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:41 09/14/2022
// Design Name:   counter_4_bit_structural
// Module Name:   C:/Users/Student/Assign5/tb_counter_4_bit_structural.v
// Project Name:  Assign5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter_4_bit_structural
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

/*
	* Assignment-5
	* Problem - 1
	* Semester - 5 (Autumn)
	* Group - 56
	* Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)
*/

module tb_counter_4_bit_structural;

	// Inputs
	reg clk = 0;
	reg rst = 1;

	// Outputs
	wire [3:0] counter;

	// Instantiate the Unit Under Test (UUT)
	counter_4_bit_structural uut (
		.clk(clk), 
		.rst(rst), 
		.counter(counter)
	);
	
	always #5 clk = ~clk;

	initial begin
		#500000000 rst = 0;
		#500000000 rst = 1;
	end
      
endmodule

