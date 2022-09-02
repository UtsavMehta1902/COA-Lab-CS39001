`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:28 08/26/2022
// Design Name:   _16_bit_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/tb_16_bit_adder.v
// Project Name:  Asgn_3_Grp_56
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: _16_bit_adder
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

module tb_16_bit_adder;

    // Inputs and Outputs
    reg [15:0] input_a, input_b;
    reg carry_in;
   wire [15:0] sum;
    wire carry_out;

    // Module Instantiations (Unit Under Test)
    s16_bit_adder tb_(input_a, input_b, carry_in, sum, carry_out);

    initial begin
        
        $monitor ("a = %d, b = %d, carry_in = %d, sum = %d, carry_out", input_a, input_b, carry_in, sum, carry_out);

        // Input values initialization
        input_a = 16'd3237;
		  input_b = 16'd1172;
		  carry_in = 1;
        #50;
        input_a = 16'd2434;
		  input_b = 16'd12;
		  carry_in = 0;
        #50;
        input_a = 16'd6431;
		  input_b = 16'd3000;
		  carry_in = 1;
        #50;
        input_a = 16'd122;
		  input_b = 16'd61421;
		  carry_in = 0;

    end

endmodule
