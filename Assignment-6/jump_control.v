`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module jump_control (opcode, sign, carry, zero, validJump);

    input [5:0] opcode;
    input sign, carry, zero;
    output reg validJump;

    always @(*) begin
        validJump = 0;
        case (opcode)
            6'b000111 : begin           
                if (sign && !zero)
                    validJump = 1;
            end
            6'b001000 : begin           
                if (!sign && zero)
                    validJump = 1;
            end
            6'b001001 : begin           
                if (!zero)
                    validJump = 1;
            end
            6'b001010 :      
                    validJump = 1;
            6'b001011 :           
                    validJump = 1;
            6'b001100 :      
                    validJump = 1;
            6'b001101 : begin
                if (carry)
                    validJump = 1;
            end
            6'b001110 : begin           
                if (!carry)
                    validJump = 1;
            end
            default : validJump = 0;
        endcase
    end

endmodule