`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:01:51 08/26/2022
// Design Name:   s8_bit_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/tb_4_bit_adder.v
// Project Name:  Asgn_3_Grp_56
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: s8_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

/* 

    * Assignment - 3
    * Problem - 3.c
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/


module tb_4_bit_adder;

    // Inputs and Outputs
    reg [3:0] a;
	reg [3:0] b;
    reg c_in;
    wire[3:0] sum;
    wire carry_out;

    // Module Instantiations (Unit Under Test)
    s4_bit_adder tb_(a, b, c_in, sum, carry_out);

    initial begin

        $monitor ("a = %d, b = %d, carry_in = %d, sum = %d, carry_out", a, b, c_in , sum, carry_out);

        // Input values initialization
        a = 4'b1111; b=4'b1100; c_in = 1;
        #50;
        a = 4'b0101; b=4'b0100; c_in = 0;
        #50;
        a = 4'b1011; b=4'b1001; c_in = 0;
        #50;
        a = 4'b1010; b=4'b0101; c_in = 1;

    end

endmodule

