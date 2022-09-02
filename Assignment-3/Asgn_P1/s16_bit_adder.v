`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:09 08/26/2022 
// Design Name: 
// Module Name:    s16_bit_adder 
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

module s16_bit_adder (a, b, carry_in, sum, carry_out);

    // Inputs and Outputs
    input [15:0] a, b;
    input carry_in;
    output [15:0] sum;
    output carry_out;

    // Internal, Temporary Variables
    wire carry_temp;

    // Use two 8-bit RCAs to build a 16-bit RCAs
    s8_bit_adder s0 (a[7:0], b[7:0], carry_in, sum[7:0], carry_temp);
    s8_bit_adder s1 (a[15:8], b[15:8], carry_temp, sum[15:8], carry_out);

endmodule
