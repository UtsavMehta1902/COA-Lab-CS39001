`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module adder_32_bit (a, b, c_in, sum, c_out);

    input [31:0] a, b;
    input c_in;
    output c_out;
    output [31:0] sum;

    wire carry;

    CLA_16_bit cla1 (.a(a[15:0]), .b(b[15:0]), .c_in(c_in), .sum(sum[15:0]), .c_out(carry));
    CLA_16_bit cla2 (.a(a[31:16]), .b(b[31:16]), .c_in(carry), .sum(sum[31:16]), .c_out(c_out));

endmodule
