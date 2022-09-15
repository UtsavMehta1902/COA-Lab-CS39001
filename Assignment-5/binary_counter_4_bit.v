`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:18 09/14/2022 
// Design Name: 
// Module Name:    binary_counter_4_bit 
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

module binary_counter_4_bit(clk100mhz, switch, reset,cntr);

	input wire clk100mhz, switch, reset;
	output reg [3:0] cntr = 4'b0000;
	
	wire clk_out;
	clock_divider cd(.clk(clk100mhz), .clk_out(clk_out));
	
	always@ (posedge clk_out or posedge reset)
	begin
	if(reset==1) cntr <= 4'b0000;
	else begin
		if(switch == 0) cntr <= cntr;
		if (switch==1) cntr <= cntr + 4'b0001;
	end
	end

endmodule
