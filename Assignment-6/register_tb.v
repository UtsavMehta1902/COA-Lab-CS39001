`timescale 1ns/1ps


module register_tb;

    reg[4:0] rs;
    reg[4:0] rt;
    reg regWrite;
    reg[4:0] writeReg;
    reg[31:0] writeData;
    reg clk, rst;
    wire[31:0] readReg_1,readReg_2;

    register uut(
        .rs(rs),
        .rt(rt),
        .regWrite(regWrite),
        .writeReg(writeReg),
        .writeData(writeData),
        .clk(clk),
        .rst(rst),
        .readReg_1(readReg_1),
        .readReg_2(readReg_2)
    );

initial begin
    // Monitor the changes
    $monitor("time = %0d, rs = %d, rt = d, readReg_1 = %d, readReg_2 = %d", $time, rs, rt, readReg_1, readReg_2);
    
    // Stimulus to verify the working of the register file
    clk = 1'b0; regWrite = 1'b0; writeData = 75;
    #2 rst = 1'b1;
    #1 rst = 1'b0;
    #5 rs = 5'b10101; rt = 5'b00101; regWrite = 1'b1; writeData = 45; writeReg = 5'b10101;
    #10 regWrite = 1'b0; writeData = 45; writeReg = 5'b10101;
    #10 regWrite = 1'b1; writeData = 45; writeReg = 5'b10111;
    #10 rs = 5'b10111; writeData = 45; writeReg = 5'b10111;
    #5 $finish;
end

// Change the clock signal after every 5 time units
always begin
    #5 clk = ~clk;
end     

endmodule