`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:01 08/26/2022
// Design Name:   half_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/tb_half_adder.v
// Project Name:  Asgn_3_Grp_56
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: half_adder
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
    * Problem - 1.a
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module tb_half_adder;

    // Inputs and Outputs
    reg input_a, input_b;
    wire sum, carry;

    // Module Instantiations (Unit Under Test)
    half_adder h_a(input_a, input_b, sum, carry);

    initial begin
        
        $monitor ("a = %d, b = %d, sum = %d, carry = %d", input_a, input_b, sum, carry);

        // Input values initialization
        input_a = 0;
		  input_b = 0;
        #50;
        input_a = 1;
		  input_b = 0;
        #50;
        input_a = 0;
		  input_b = 1;
        #50;
        input_a = 1;
		  input_b = 1;

    end

endmodule