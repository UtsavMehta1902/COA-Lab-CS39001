`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:20 08/26/2022 
// Design Name: 
// Module Name:    s32_bit_adder 
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

module s32_bit_adder (a, b, carry_in, sum, carry_out);

    // Inputs and Outputs
    input [31:0] a, b;
    input carry_in;
    output [31:0] sum;
    output carry_out;

    // Internal, Temporary Variables
    wire carry_temp;

    // Use two 16-bit RCAs to build a 32-bit RCAs
    s16_bit_adder s0 (a[15:0], b[15:0], carry_in, sum[15:0], carry_temp);
    s16_bit_adder s1 (a[31:16], b[31:16], carry_temp, sum[31:16], carry_out);

endmodule