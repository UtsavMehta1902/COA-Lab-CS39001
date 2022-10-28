`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module diff_tb;

    reg [31:0] a, b;
    wire [5:0] result;

    diff d(a, b, result);
    initial begin

        $monitor ("a = %d, b = %d, result = %d", a, b, result);

        a=32'd0; b = 32'd0;
        #100;
        a=32'd125; b = 32'd3;
        
    end

endmodule