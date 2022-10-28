`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module register (rs, rt, regWrite, writeReg, writeData, clk, rst, readReg_1, readReg_2);

    input [4:0] rs;
    input [4:0] rt;
    input regWrite;
    input [4:0] writeReg;
    input [31:0] writeData;
    input clk;
    input rst;
    output reg [31:0] readReg_1;
    output reg [31:0] readReg_2;

    reg signed [31:0] registerMemory [31:0];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (integer i = 0; i < 32; i = i + 1)
                registerMemory[i] <= 32'b00000000000000000000000000000000;
        end else if (regWrite)
            registerMemory[writeReg] <= writeData;    
    end

    always @(*) begin
        readReg_1 = registerMemory[rs];
        readReg_2 = registerMemory[rt];
    end

endmodule