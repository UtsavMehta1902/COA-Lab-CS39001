`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 2.b
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module carry_look_ahead(p, g, c, c_in, c_out, p_out, g_out);

    // Inputs and Outputs
    input [3:0] p, g;
    input c_in;
    output [3:0] c;
    output c_out, p_out, g_out;

    // Carry-bit computations (Carry-chain)
    assign c[0] = c_in;
    assign c[1] = g[0] | (p[0] & c_in);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c_in);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c_in);
    assign c_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c_in);

    // Propagate and Generate computations for the next level
    assign p_out = p[3] & p[2] & p[1] & p[0];
    assign g_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule