`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:10 09/14/2022
// Design Name:   binary_counter_4_bit
// Module Name:   C:/Users/Student/Assign5/tb_binary_counter_4_bit.v
// Project Name:  Assign5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: binary_counter_4_bit
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
module tb_binary_counter_4_bit;

	// Inputs
	reg clk=0;
	reg reset=1;

	// Outputs
	wire [3:0] cntr;

	// Instantiate the Unit Under Test (UUT)
	binary_counter_4_bit uut (
		.clk100mhz(clk), 
		.switch(switch), 
		.reset(reset), 
		.cntr(cntr)
	);

	always #5 clk = ~clk;

	initial begin
		#500 rst = 0;
		#500 rst=1;

	end
      
endmodule

