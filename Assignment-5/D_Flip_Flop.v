`timescale 1ns/1ps

module D_Flip_Flop(clk, reset, D, Q);

    input clk, reset, D;
    output Q;

    always @(posedge clk or posedge reset)
    if (reset != 0)
        Q <= D;
    else
        Q <= 0;

endmodule