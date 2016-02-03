module FourBitMagComp(input[3:0] a, input[3:0] b, output eq, output lt, output gt);
    assign eq = a == b;
    assign lt = a < b;
    assign gt = a > b;
endmodule

module EightBitMagComp(input[7:0] a, input[7:0] b, output eq, output lt, output gt);
    wire tempEQ1, tempLT1, tempGT1;
    wire tempEQ2, tempLT2, tempGT2;
    
    FourBitMagComp first4BitMagComp(a[7:4], b[7:4], tempEQ1, tempLT1, tempGT1);
    FourBitMagComp second4BitMagComp(a[3:0], b[3:0], tempEQ2, tempLT2, tempGT2);
    
    assign eq = tempEQ1 & tempEQ2;
    assign gt = tempGT1 | (tempEQ1 & tempGT2);
    assign lt = ~eq & ~gt;
endmodule

module EightBitMagComp_tb;
    reg[7:0] a, b;
    wire eq, lt, gt;
    
    EightBitMagComp eightBitMagComp(a, b, eq, lt, gt);
    initial begin
        $monitor("%d a=%d, b=%d -> eq=%b, lt=%b, gt=%b", $time, a, b, eq, lt, gt);
        #10 a=8'd10;
            b=8'd9;
        #10 a=8'd66;
            b=8'd107;
        #10 a=8'd49;
            b=8'd49;
        #10 $finish;
    end
endmodule