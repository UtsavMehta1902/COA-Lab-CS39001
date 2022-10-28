`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module diff(a, b, out_diff);

    input [31:0] a, b;
    output [5:0] out_diff;

    wire [31:0] result, n, temp1, temp2;

    wire temp;
    assign n = a ^ b;
    
    adder_32_bit n_minus_one(.a(n), .b(32'b11111111111111111111111111111111), .c_in(1'b0), .sum(temp1), .c_out(temp));
    assign temp2 = temp1 ^ n;
    assign result = temp2 & n;

    encoder enc(.in(result), .out_diff(out_diff[5:0]));
endmodule