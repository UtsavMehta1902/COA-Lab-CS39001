`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:28 08/31/2022 
// Design Name: 
// Module Name:    wrapper_CLA_16_bit 
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
module wrapper_CLA_16_bit_ripple(input clk, input rst, input [15:0] in_data1, input [15:0] in_data2, input cnet, output reg [15:0] out_data, output reg c);

reg [15:0] in1_reg;
reg [15:0] in2_reg;
reg cin;
wire [15:0] out_net;
wire cout;
always @(posedge clk)
    begin
        if(rst)
            begin
                in1_reg<=16'd0;
                in2_reg<=16'd0;
					 cin<=1'b0;
					 out_data<=16'd0;
					 c<=1'b0;
            end
        else
            begin
                in1_reg<=in_data1;
                in2_reg<=in_data2;
					 cin<=cnet;
					 out_data<=out_net;
					 c<=cout;
            end
    end

CLA_16_bit_ripple CLA_unit(in1_reg, in2_reg, cin, out_net, cout);

endmodule
