`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 3.c
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module CLA_16_bit_ripple(a, b, c_in, sum, c_out);

    // Inputs and Outputs
    input [15:0] a,b;
    input c_in;
    output [15:0] sum;
    output c_out;

    // Temporary variables used in the circuit
    wire [2:0] carry;

    // Using the augmented 4 bit CLAs for calculating the sum
    CLA_4_bit CLA_4_bit_1(.a(a[3:0]), .b(b[3:0]), .sum(sum[3:0]), .c_in(c_in), .c_out(carry[0]));
    CLA_4_bit CLA_4_bit_2(.a(a[7:4]), .b(b[7:4]), .sum(sum[7:4]), .c_in(carry[0]), .c_out(carry[1]));
    CLA_4_bit CLA_4_bit_3(.a(a[11:8]), .b(b[11:8]), .sum(sum[11:8]), .c_in(carry[1]), .c_out(carry[2]));
    CLA_4_bit CLA_4_bit_4(.a(a[15:12]), .b(b[15:12]), .sum(sum[15:12]), .c_in(carry[2]), .c_out(c_out));

endmodule