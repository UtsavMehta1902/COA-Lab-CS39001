`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:26:04 08/26/2022
// Design Name:   _32_bit_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/tb_32_bit_adder.v
// Project Name:  Asgn_3_Grp_56
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: _32_bit_adder
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

module tb_32_bit_adder;

    // Inputs and Outputs
    reg [31:0] input_a, input_b;
    reg carry_in;
    wire [31:0] sum;
    wire carry_out;

    // Module Instantiations (Unit Under Test)
    s32_bit_adder tb_(input_a, input_b, carry_in, sum, carry_out);

    initial begin
        
        $monitor ("a = %d, b = %d, carry_in = %d, sum = %d, carry_out", input_a, input_b, carry_in, sum, carry_out);

        // Input values initialization
        input_a = 32'd321937;
		  input_b = 32'd1172056;
		  carry_in = 1;
        #50;
        input_a = 32'd23;
		  input_b = 32'd12;
		  carry_in = 0;
        #50;
        input_a = 32'd415362004;
		  input_b = 32'd23907432;
		  carry_in = 1;
        #50;
        input_a = 32'd128;
		  input_b = 32'd89031;
		  carry_in = 0;

    end

endmodule

