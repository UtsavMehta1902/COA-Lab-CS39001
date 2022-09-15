`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:42 09/14/2022 
// Design Name: 
// Module Name:    clock_divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

/*
	* Assignment-5
	* Problem - 1
	* Semester - 5 (Autumn)
	* Group - 56
	* Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)
*/

module clock_divider(clk,clk_out);
	
	input wire clk;
	output reg clk_out=0;
	integer counter = 0;
	localparam SCALE_FACTOR=2499999;
	
	always@ (posedge clk)
	begin
	
	if(counter == SCALE_FACTOR)
		begin
			counter <=0;
			clk_out <= ~clk_out;
		end	
	else
		begin
			counter <= counter + 1;
			clk_out <= clk_out;
		end
	end
endmodule
