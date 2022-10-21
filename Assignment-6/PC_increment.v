`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module PC_increment(PC, PC_incremented);

    input [31:0] PC;
    output [31:0] PC_incremented;

    assign PC_incremented = PC + 32'd4;

endmodule