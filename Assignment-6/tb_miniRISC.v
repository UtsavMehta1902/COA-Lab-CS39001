`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module tb_miniRISC;

	reg clk;
	reg rst;
    
	miniRISC uut (clk, rst);

	initial begin
        
		clk = 0;
		rst = 1;
        #5 rst = 0;
   
       #2905 
        $display ("Register 19 content (it's implication on next line): %d", uut.DP.registerFile.registerMemory[19]);
        if (uut.DP.registerFile.registerMemory[19] == -1)
            $display("Element not found.");
        else
            $display("Element found at index: %d", uut.DP.registerFile.registerMemory[19]);
        $finish;
        
    end
    
    always #10 clk = ~clk;
      
endmodule