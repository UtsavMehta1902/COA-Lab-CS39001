`timescale 1ns/1ps

/* 

    * Assignment - 3
    * Problem - 2.b
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module tb_carry_look_ahead;

    // Inputs and Outputs
    reg [3:0] p, g;
    reg c_in;
    wire [3:0] c;
    wire p_out, g_out, c_out;

    // Module Instantiations (Unit Under Test)
    carry_look_ahead tb_(.p(p), .g(g), .c(c), .c_in(c_in), .c_out(c_out), .p_out(p_out), .g_out(g_out));

    initial begin

        $monitor("Propagate = %d, Generate = %d, Carry_in = %d, Carry = %d, Carry_out = %d, Propagate_out = %d, Generate_out = %d", p, g, c_in, c, c_out, p_out, g_out);

        // Input values initialization
        p = 4'b1111; g=4'b1100; c_in = 1;
        #50;
        p = 4'b0101; g=4'b0100; c_in = 0;
        #50;
        p = 4'b1011; g=4'b1001; c_in = 0;
        #50;
        p = 4'b1010; g=4'b1110; c_in = 1;

    end

endmodule