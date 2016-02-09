module TFlipFlop(input t, input clk, input clr, output q);
    reg q, dIn;
    wire dQ;
    DFlipFlop dFlipFlop(clk, clr, dIn, dQ);
    
    always @( t, dQ, posedge clr) begin
        dIn = t ^ dQ;
        q = dQ;
    end
endmodule

module DFlipFlop(input clk, input clr, input d, output q);
    reg q;
    
    always @(negedge clk, clr)
        if(clr)
            q = 0;
        else
            q = d;
endmodule

module TFlipFlop_tb;
    reg t, clr, clk;
    wire q;
    TFlipFlop tFlipFlop(t, clk, clr, q);
    
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
        $monitor("%d t=%b clk=%b clr=%b q=%b", $time, t, clk, clr, q);
        t=0;
        #10 t=0;
        #10 t=1;
        #10 t=0;
        #10 t=1;
        #10 t=0;
        #10 t=0;
        #10 t=1;
        #10 t=0;
        #10 $finish;
    end
endmodule