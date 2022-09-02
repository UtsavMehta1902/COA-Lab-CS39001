`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:45 08/26/2022 
// Design Name: 
// Module Name:    s64_bit_adder 
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

module s64_bit_adder (a, b, carry_in, sum, carry_out);

  // Inputs and Outputs
  input [63:0] a, b;
  input carry_in;
  output [63:0] sum;
  output carry_out;
  
  // Internal, Temporary Variables
  wire carry_temp;

  // Use two 32-bit RCAs to build a 64-bit RCAs
  s32_bit_adder s0 (a[31:0], b[31:0], carry_in, sum[31:0], carry_temp);
  s32_bit_adder s1 (a[63:32], b[63:32], carry_temp, sum[63:32], carry_out);
  
endmodule