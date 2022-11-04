`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module ALU_tb;
    
    reg signed [31:0] a;
    reg signed [31:0] b; 
    reg ALUsel;
    reg [4:0] ALUop; 

    wire carry;
    wire zero;
    wire sign; 
    wire [31:0] result;

    ALU_unit ALU1 (
        .a(a), 
        .b(b), 
        .ALUsel(ALUsel), 
        .ALUop(ALUop), 
        .carry(carry), 
        .zero(zero), 
        .sign(sign), 
        .result(result)
    );
    
    initial begin
        
        $monitor("time = %0d, a = %d, b = %d, ALUsel = %b, ALUop = %b, carry = %b, zero = %b, sign = %b, result = %d", $time, a, b, ALUsel, ALUop, carry, zero, sign, result);
        
        b = 32'd10;
        a = 32'd15;
        ALUsel = 1'b0;
        ALUop = 5'b00000;
        #5 ALUop = 5'b00001;
        #5 ALUop = 5'b00101;
        #5 ALUop = 5'b10101;
        #5 ALUop = 5'b00010;
        #5 ALUop = 5'b00011;
        #5 ALUop = 5'b01010;
        #5 ALUop = 5'b01000;
        #5 ALUop = 5'b01010;
        #5 ALUop = 5'b01000;
        #5 ALUop = 5'b01001;
        #5 ALUop = 5'b01001;

        #5 ALUsel = 1'b1; ALUop = 5'b00001;
        #5 ALUop = 5'b00101;
        #5 ALUop = 5'b10101;
        #5 ALUop = 5'b00010;
        #5 ALUop = 5'b00011;
        #5 ALUop = 5'b01010;
        #5 ALUop = 5'b01000;
        #5 ALUop = 5'b01010;
        #5 ALUop = 5'b01000;
        #5 ALUop = 5'b01001;
        #5 ALUop = 5'b01001;  
        #5 $finish;
    end
endmodule