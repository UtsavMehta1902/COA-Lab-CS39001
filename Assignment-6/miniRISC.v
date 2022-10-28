`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module miniRISC (clk, rst);

    input clk, rst;

    wire [5:0] opcode;
    wire [4:0] func;
    wire [1:0] regDst;
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire [1:0] memToReg;
    wire ALUsrc;
    wire [4:0] ALUop;
    wire ALUsel;
    wire branch;
    wire jumpAddr;
    wire lblSel;

    control_unit CU (opcode, func, regDst, regWrite, memRead, memWrite, memToReg, ALUsrc, ALUop, ALUsel, branch, jumpAddr, lblSel);
    datapath DP (regDst, regWrite, memRead, memWrite, memToReg, ALUop, ALUsrc, ALUsel, branch, jumpAddr, lblSel, clk, rst, opcode, func);
    
endmodule