`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module branch_unit(PC_incremented, in1, in2, regAddr, lblSel, jumpAddr, branch, validJump, PC_new);

    input [31:0] PC_incremented;
    input [25:0] in1;
    input [15:0] in2;
    input [31:0] regAddr;
    input lblSel, jumpAddr, branch, validJump;
    output [31:0] PC_new;

    wire [31:0] in1_extended, in2_extended, out_mux1, out_mux2;
    wire jump;

    assign in1_extended = {{6{in1[25]}}, in1};
    assign in2_extended = {{16{in2[15]}}, in2};

    and gate (lblSel, branch, jump);

    mux_32_to_1 mux1 (.a(in1_extended), .b(in2_extended), .select(lblSel), .out(out_mux1));
    mux_32_to_1 mux2 (.a(out_mux1), .b(regAddr), .select(jumpAddr), .out(out_mux2));
    mux_32_to_1 mux3 (.a(PC_incremented), .b(out_mux2), .select(jump), .out(PC_new));

endmodule