`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:34:54 08/26/2022
// Design Name:   _64_bit_adder
// Module Name:   C:/Users/Student/Asgn_3_Grp_56/substractor.v
// Project Name:  Asgn_3_Grp_56
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: _64_bit_adder
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
    * Problem - 1.d
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module substractor;

	// Inputs and Outputs
	reg [63:0] input_a;
	reg [63:0] input_b;
	reg carry_in;
	wire [63:0] sum;
	wire carry_out;

	// Module Instantiations (Unit Under Test)
	s64_bit_adder tb_(input_a, input_b, carry_in, sum, carry_out);

	initial begin
		
		$monitor ("a = %d, b = %d, carry_in = %d, sum = %d, carry_out", input_a, input_b, carry_in, sum, carry_out);
		/*input_b=64'd5298;							// The value of b (to be used as -b)
		input_a = 1;							// Adding 1 to the complement of b
		input_b = ~input_b; 					// b <-- -b, taking one's complement of b
		carry_in = 0;*/
		#50
		
		// Input values initialization
		input_a=64'd76575785;
		input_b=64'd5298;
		input_b = ~input_b;
		carry_in = 1;
		
		#50
		
		input_a=64'd2319840;
		input_b=64'd340;
		input_b = ~input_b;
		carry_in = 1;
	end
      
endmodule

