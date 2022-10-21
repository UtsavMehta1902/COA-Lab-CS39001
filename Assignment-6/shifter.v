`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

// arith_or_logic is 1 for arithmetic shift and 0 for logical shift

module shifter(in, shamt, dir, arith_or_logic, out);

    input signed [31:0] in;
    input [31:0] shamt;
    input dir, arith_or_logic;
    output reg [31:0] out;

    always @(*) begin
        if(arith_or_logic) begin
            if(dir)
                out = in;
            else
                out = in >>> shamt;
        end
        else begin
            if(dir)
                out = in << shamt;
            else
                out = in >> shamt;
        end
    end

endmodule