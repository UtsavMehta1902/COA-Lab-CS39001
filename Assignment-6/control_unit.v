`timescale 1ns/1ps

/* 

    * Assignment - 6
    * Problem - 3
    * Semester - 5 (Autumn)
    * Group - 56
    * Group members - Utsav Mehta (20CS10069) and Vibhu (20CS10072)

*/

module control_unit(opcode, func, regDst, regWrite, memRead, memWrite, memToReg, ALUsrc, ALUop, ALUsel, branch, jumpAddr, lblSel);

    input [5:0] opcode;
    input [4:0] func;
    output reg [1:0] regDst, memToReg;
    output reg ALUsrc, regWrite, memRead, memWrite, ALUsel, branch, jumpAddr, lblSel;
    output reg [4:0] ALUop;

    always @(opcode or func) begin
        case (opcode)
            6'b000000 : begin
                case (func)
                    5'b00000 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00001;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end 
                    5'b00001 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00101;
                        ALUsel = 1'b1;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                    default: begin        
                        regDst = 2'b00;
                        regWrite = 1'b0;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                endcase
            end
            6'b000001 : begin
                case (func)
                    5'b00000 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00010;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end 
                    5'b00001 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00011;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                    default: begin          
                        regDst = 2'b00;
                        regWrite = 1'b0;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                endcase
            end
            6'b000010 : begin
                case (func)
                    5'b00000 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b01010;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end 
                    5'b00001 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b01000;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                    5'b00010 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b01010;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end 
                    5'b00011 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b01000;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                    5'b00100 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b01001;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end 
                    5'b00101 : begin        
                        regDst = 2'b00;
                        regWrite = 1'b1;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b01001;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                    default: begin          
                        regDst = 2'b00;
                        regWrite = 1'b0;
                        memRead = 1'b0;
                        memWrite = 1'b0;
                        memToReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        branch = 1'b0;
                        jumpAddr = 1'b0;
                        lblSel = 1'b0;
                    end
                endcase
            end
            6'b000011 : begin               
                regDst = 2'b00;
                regWrite = 1'b1;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b10;
                ALUsrc = 1'b1;
                ALUop = 5'b00001;
                ALUsel = 1'b0;
                branch = 1'b0;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b000100 : begin               
                regDst = 2'b00;
                regWrite = 1'b1;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b10;
                ALUsrc = 1'b1;
                ALUop = 5'b00101;
                ALUsel = 1'b1;
                branch = 1'b0;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b000101 : begin               
                regDst = 2'b01;
                regWrite = 1'b1;
                memRead = 1'b1;
                memWrite = 1'b0;
                memToReg = 2'b01;
                ALUsrc = 1'b1;
                ALUop = 5'b10101;
                ALUsel = 1'b0;
                branch = 1'b0;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b000110 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b1;
                memToReg = 2'b00;
                ALUsrc = 1'b1;
                ALUop = 5'b10101;
                ALUsel = 1'b0;
                branch = 1'b0;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b000111 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b1;
            end
            6'b001000 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b1;
            end
            6'b001001 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b1;
            end
            6'b001010 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b1;
                lblSel = 1'b0;
            end
            6'b001011 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b001100 : begin               
                regDst = 2'b10;
                regWrite = 1'b1;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b001101 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            6'b001110 : begin               
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b1;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
            default: begin             
                regDst = 2'b00;
                regWrite = 1'b0;
                memRead = 1'b0;
                memWrite = 1'b0;
                memToReg = 2'b00;
                ALUsrc = 1'b0;
                ALUop = 5'b00000;
                ALUsel = 1'b0;
                branch = 1'b0;
                jumpAddr = 1'b0;
                lblSel = 1'b0;
            end
        endcase
    end

endmodule