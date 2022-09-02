`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 1.b
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module full_adder (a, b, carry0, sum, carry1);

    // Inputs and Outputs
    input a, b, carry0;
    output sum, carry1;

    // Internal, Temporary Variables
    wire temp_sum, temp_carry0, temp_carry1;

    // Use two half adders to generate a full adder
    half_adder ha0(a, b, temp_sum, temp_carry0);
    half_adder ha1(temp_sum, carry0, sum, temp_carry1);
    assign carry1 = temp_carry0 | temp_carry1;

endmodule