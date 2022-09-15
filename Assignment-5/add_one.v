`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:30 09/14/2022 
// Design Name: 
// Module Name:    add_one 
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

module add_one(a, sum);
	input [3:0] a;
	output [3:0] sum;
	
	wire [3:0] c,p;
	
	assign c[0] = 0;
	assign c[1] = a[0];
	assign c[2] = a[1] & a[0];
	assign c[3] = a[2] & a[1] & a[0];
	
	assign p[3:1]  = a[3:1];
	assign p[0] = ~ a[0];
	
	assign sum = p ^ c;


endmodule
