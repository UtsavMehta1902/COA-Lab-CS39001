`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module mux_2_to_1(a, b, select, out);

    input a, b, select;
    output out;

    assign out = (select) ? b : a;

endmodule