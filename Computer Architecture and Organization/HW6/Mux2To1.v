
module Mux2To1(input a, input b, input sel, output z);
    assign z = sel ? b : a;
endmodule

module Mux2To1TB;
    reg a, b, sel;
    wire z;
    
    Mux2To1 mux(a, b, sel, z);
    
    initial begin
        #10
            a = 1'b0;
            b = 1'b1;
            sel = 1'b0;
        #10
            sel = 1'b1;
        #10
            $finish;
    end
endmodule