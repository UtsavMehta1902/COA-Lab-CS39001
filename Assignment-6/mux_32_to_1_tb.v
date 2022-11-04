`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module mux_32_to_1_tb;

    reg [31:0] a, b;
    reg select;
    wire [31:0] out;

    mux_32_to_1 mux1 (.a(a), .b(b), .select(select), .out(out));

    initial begin
        a = 32'd0;
        b = 32'd0;
        select = 1'b0;

        $monitor("a = %d, b = %d, select = %d, out = %d", a, b, select, out);
        #100;
        a <= 32'd15;
        b <= 32'd10;
        select <= 1'b0;
        #100;
        a <= 32'd15;
        b <= 32'd10;
        select <= 1'b1;
        #100;
    end

endmodule