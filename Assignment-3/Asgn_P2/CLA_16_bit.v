`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 3.b
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module CLA_16_bit(a, b, c_in, sum, c_out, Prop, Gen);

    // Inputs and Outputs
    input [15:0] a,b;
    input c_in;
    output [15:0] sum;
    output c_out, Prop, Gen;

    // Temporary variables used in the circuit
    wire [3:0] p, g, carry;

    // Using the augmented 4 bit CLAs for calculating the sum
    CLA_4_bit_augmented CLA_4_bit_1(.a(a[3:0]), .b(b[3:0]), .sum(sum[3:0]), .c_in(c_in), .c_out(), .prop(p[0]), .gen(g[0]));
    CLA_4_bit_augmented CLA_4_bit_2(.a(a[7:4]), .b(b[7:4]), .sum(sum[7:4]), .c_in(carry[1]), .c_out(), .prop(p[1]), .gen(g[1]));
    CLA_4_bit_augmented CLA_4_bit_3(.a(a[11:8]), .b(b[11:8]), .sum(sum[11:8]), .c_in(carry[2]), .c_out(), .prop(p[2]), .gen(g[2]));
    CLA_4_bit_augmented CLA_4_bit_4(.a(a[15:12]), .b(b[15:12]), .sum(sum[15:12]), .c_in(carry[3]), .c_out(), .prop(p[3]), .gen(g[3]));

    // Integrating the Carry Look Ahead unit
    carry_look_ahead CLA_unit(.p(p), .g(g), .c(carry), .c_in(c_in), .c_out(c_out), .p_out(Prop), .g_out(Gen));

endmodule