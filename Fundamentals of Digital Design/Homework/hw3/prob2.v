module Incrementor(input inc, input clk, input clr, output[31:0] value);
    reg[31:0] dIn, value;
    wire[31:0]dOut;
    DFlipFlop32Bits dFlipFlop32Bits(clk, clr, dIn, dOut);
    
    always @(negedge clk, dOut) begin
        if(inc)
            dIn = dOut + 32'd3;
        else
            dIn = dOut;
        value = dOut;
    end
endmodule

module DFlipFlop32Bits(input clk, input clr, input[31:0] d, output[31:0] q);
    reg[31:0] q;
    
    always @(negedge clk, posedge clr)
        if(clr)
            q = 32'd0;
        else
            q = d;
endmodule

module incrementor_tb;
    reg inc, clk, clr;
    wire[31:0] value;
    Incrementor incrementor(inc, clk, clr, value);
    
    initial begin
        clr = 1;
        #10 clr = 0;
    end
    
    initial begin
        clk = 1;
        forever
            #5 clk = ~clk;
    end
    
    initial begin
        $monitor("%d inc=%b clk=%b clr=%b value=%d", $time, inc, clk, clr, value);
        inc = 0;
        #10 inc = 1;
        #20 inc = 0;
        #10 inc = 1;
        #10 inc = 0;
        #10 inc = 1;
        #10 $finish;
    end
endmodule