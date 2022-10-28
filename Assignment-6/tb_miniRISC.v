`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

// Testbench for the KGPRISC top module
module tb_miniRISC;

	reg clk;
	reg rst;
    
	miniRISC uut (clk, rst);

	initial begin
        
		clk = 0;
		rst = 1;
        #5 rst = 0;
   
       #2905 
        $display ("Content in register 19: %d", uut.DP.registerFile.registerBank[19]);
        if (uut.DP.registerFile.registerBank[19] == -1) begin
            $display("Element not found.");
        end else begin
            $display("Element found at index: %d", uut.DP.registerFile.registerBank[19]);
        end
        $finish;
        
    end
    
    always begin
        #10 
        clk = ~clk;
    end
      
endmodule
