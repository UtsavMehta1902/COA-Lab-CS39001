`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module adder_tb;

    reg signed [31:0] a, b;
    reg c_in;
    wire c_out;
    wire [31:0] sum;

    adder_32_bit adder (.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));

    initial begin
        a = 32'd0;
        b = 32'd0;
        c_in = 1'b0;

        $monitor("a = %d, b = %d, c_in = %d, c_out = %d, sum = %d", a, b, c_in, c_out, sum);
        #10;
        a = 32'd15;
        b = 32'd10;
        c_in = 1'b0;
        #10;
    end

endmodule