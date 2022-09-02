`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:27 08/26/2022 
// Design Name: 
// Module Name:    s8_bit_adder 
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

    * Assignment - 3
    * Problem - 1.c
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module s8_bit_adder (a, b, carry_in, sum, carry_out);

    // Inputs and Outputs
    input [7:0] a;
	input [7:0]	 b;
    input carry_in;
    output [7:0] sum;
    output carry_out;

    // Internal, Temporary Variables
    wire [6:0] carry_temp;

    // Use 8 full adders to generate 8-bit ripple carry adder
    full_adder fa0 (a[0], b[0], carry_in, sum[0], carry_temp[0]);
    full_adder fa1 (a[1], b[1], carry_temp[0], sum[1], carry_temp[1]);
    full_adder fa2 (a[2], b[2], carry_temp[1], sum[2], carry_temp[2]);
    full_adder fa3 (a[3], b[3], carry_temp[2], sum[3], carry_temp[3]);
    full_adder fa4 (a[4], b[4], carry_temp[3], sum[4], carry_temp[4]);
    full_adder fa5 (a[5], b[5], carry_temp[4], sum[5], carry_temp[5]);
    full_adder fa6 (a[6], b[6], carry_temp[5], sum[6], carry_temp[6]);
    full_adder fa7 (a[7], b[7], carry_temp[6], sum[7], carry_out);

endmodule
