`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module ALU_unit(a, b, ALUsel, ALUop, carry, zero, sign, result);

    input signed [31:0] a, b;
    input ALUsel;
    input [4:0] ALUop;
    output reg carry, zero, sign;
    output reg [31:0] result;

    wire temp_carry;
    wire [31:0] out_not, out_adder, out_shifter, out_and, out_xor, out_mux1, out_mux2;

    mux_32_to_1 mux1 (.a(a), .b(32'b00000000000000000000000000000001), .select(ALUsel), .out(out_mux1));
    mux_32_to_1 mux2 (.a(b), .b(out_not), .select(ALUsel), .out(out_mux2));

    adder_32_bit adder (.a(out_mux1), .b(out_mux2), .c_in(1'b0), c_out(temp_carry), .sum(out_adder));

    shifter shift (.in(out_mux1), .shamt(out_mux2), .dir(ALUop[1]), .arith_or_logic(ALUop[0]), .out(out_shifter));

    assign out_not = ~b;
    assign out_and = out_mux1 & out_mux2;
    assign out_xor = out_mux1 ^ out_mux2;

    always @(a or b or ALUsel or ALUop) begin
        
        if(ALUop == 5'b00000)
            result = out_mux1;
        else if (ALUop == 5'b00001) begin
            carry = temp_carry;
            result = out_adder;
        end
        else if (ALUop == 5'b00101)
            result = out_adder;
        else if (ALUop == 5'b10101)
            result = out_adder;
        else if (ALUop == 5'b00010)
            result = out_and;
        else if (ALUop == 5'b00011)
            result = out_xor;
        else if (ALUop[4:2] == 3'b010)
            result = out_shifter;
        else
            result = 32'b00000000000000000000000000000000;

    end

    always @(result) begin

        if(result == 32'b00000000000000000000000000000000)
            zero = 1'b0;
        else
            zero = 1'b1;

        if(result[31])
            sign = 1'b1;
        else
            sign = 1'b0;

    end
    
endmodule