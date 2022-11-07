`timescale 1ns / 1ps

module shifter_tb;

reg dir, arith_or_logic;
reg[31:0] in,shamt;
wire[31:0] out;

shifter uut(
    .in(in),
    .shamt(shamt),
    .dir(dir),
    .arith_or_logic(arith_or_logic),
    .out(out)
);

initial begin
    
    $monitor("time = %0d, shamt = %b, dir = %b, in = %b, out = %b, arith_or_logic = %b", $time, shamt, dir, in, out, arith_or_logic);

    in = 4567; dir = 1'b1; shamt = 4; arith_or_logic = 0;

    #5 dir = 1'b0; arith_or_logic = 1'b0;

    #5 dir = 1'b0; arith_or_logic = 1'b1;

    #5 dir = 1'b1; arith_or_logic = 1'b0; in = -64;

    #5 dir = 1'b0; arith_or_logic = 1'b0;

    #5 dir = 1'b0; arith_or_logic = 1'b1;

    #5 $finish;

end

endmodule