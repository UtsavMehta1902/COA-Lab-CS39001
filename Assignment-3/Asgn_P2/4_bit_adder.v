`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 3.b
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module _4_bit_adder (a, b, carry_in, sum, carry_out);

    // Inputs and Outputs
    input [3:0] a, b;
    input carry_in;
    output [3:0] sum;
    output carry_out;

    // Internal, Temporary Variables
    wire [2:0] carry_temp;

    // Use 8 full adders to generate 8-bit ripple carry adder
    full_adder fa0 (a[0], b[0], carry_in, sum[0], carry_temp[0]);
    full_adder fa1 (a[1], b[1], carry_temp[0], sum[1], carry_temp[1]);
    full_adder fa2 (a[2], b[2], carry_temp[1], sum[2], carry_temp[2]);
    full_adder fa3 (a[3], b[3], carry_temp[2], sum[3], c_out);

endmodule