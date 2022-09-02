`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:01:51 08/26/2022
// Design Name:   s8_bit_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/tb_8_bit_adder.v
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
    * Problem - 1.c
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module tb_8_bit_adder;

    // Inputs and Outputs
    reg [7:0] input_a;
		reg [7:0] input_b;
    reg carry_in;
    wire[7:0] sum;
    wire carry_out;

    // Module Instantiations (Unit Under Test)
    s8_bit_adder tb_(input_a, input_b, carry_in, sum, carry_out);

    initial begin

        $monitor ("a = %d, b = %d, carry_in = %d, sum = %d, carry_out", input_a, input_b, carry_in, sum, carry_out);

        // Input values initialization
        input_a = 8'd37;
		  input_b = 8'd72;
		  carry_in = 1;
        #50;
        input_a = 8'd240;
		  input_b = 8'd127;
		  carry_in = 0;
        #50;
        input_a = 8'd213;
		  input_b = 8'd3;
		  carry_in = 1;
        #50;
        input_a = 8'd53;
		  input_b = 8'd53;
		  carry_in = 0;

    end

endmodule

