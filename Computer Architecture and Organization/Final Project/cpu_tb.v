//Chris Miramontes

`timescale 1ns/100ps

module cpu_tb;
    reg clk, clr;
    wire[31:0] inst, read_data2_out;
    cpu CPU(clk, clr, inst, read_data2_out);
    
    initial begin
        clr = 1;
        #100 clr = 0;
    end
    
    initial begin
        clk = 0;
        forever
            #50 clk = ~clk;
    end
endmodule