`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module datapath (regDst, regWrite, memRead, memWrite, memToReg, ALUop, ALUsrc, ALUsel, branch, jumpAddr, lblSel, clk, rst, opcode, func);

    input [1:0] regDst;
    input regWrite;
    input memRead;
    input memWrite;
    input [1:0] memToReg;
    input ALUsrc;
    input [4:0] ALUop;
    input ALUsel;
    input branch;
    input jumpAddr;
    input lblSel;
    input clk;
    input rst;
    output [5:0] opcode;
    output [4:0] func;

    parameter ra = 5'b11111;  

    wire enable;
    wire carry, zero, sign, validJump, lastCarry;
    wire [31:0] nextInstrAddr, instruction, writeData, readData1, instrAddr, result, nextPC, readData2, SE1out, b, dataMemReadData;
    wire [25:0] label0;
    wire [15:0] label1, imm;
    wire [4:0] rs, rt, shamt, writeReg;
    wire [31:0] offset;
    
    assign enable = memRead | memWrite;         
    assign offset = nextInstrAddr >>> 2'b10;    
    
    d_flip_flop DFF (clk,rst,carry, lastCarry);

    program_counter PC (clk, rst, address, out);

    bram_instr_mem instructionMemory (
        .clka(clk),
        .ena(1'b1),
        .addra(offset[9:0]),
        .douta(instruction)
    );

    instruction_decode instructionDecoder (
        .instruction(instruction),
        .opcode(opcode),
        .func(func),
        .label0(label0),
        .label1(label1),
        .rs(rs),
        .rt(rt),
        .shamt(shamt),
        .imm(imm)
    );

    mux_4x3_to_1 MUX1 (rs,rt,ra, regDst, writeReg);

    register registerFile (
        .rs(rs),
        .rt(rt),
        .regWrite(regWrite),
        .writeReg(writeReg),
        .writeData(writeData),
        .clk(clk),
        .rst(rst),
        .readData1(readData1),
        .readData2(readData2)
    );

    sign_extend SE1 (opcode, func, imm, SE1out);

    mux_32_to_1 MUX2 (readData2, SE1out, ALUsrc, b);

    ALU_unit ALU1 (
        .a(readData1),
        .b(b),
        .ALUsel(ALUsel),
        .ALUop(ALUop),
        .carry(carry),
        .zero(zero), 
        .sign(sign),
        .result(result)
    );

    jump_control JC (opcode, sign, lastCarry, zero, validJump);

    PC_increment PCInc (instrAddr, nextPC);

    branch_unit branchUnit (nextPC, label0, label1, readData1, lblSel, jumpAddr, branch, validJump, nextInstrAddr);

    bram_data_mem dataMemory (
        .clka(~clk),
        .ena(enable),
        .wea(memWrite),
        .addra(result[9:0] >>> 2'b10),
        .dina(readData2),
        .douta(dataMemReadData)
    );

    mux_32x3_to_1 MUX3 (nextPC, dataMemReadData, result, memToReg, writeData);

endmodule