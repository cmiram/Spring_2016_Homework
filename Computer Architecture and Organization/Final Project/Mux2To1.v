
module Mux32Bit2To1(input[31:0] a, input[31:0] b, input sel, output[31:0] z);
    assign z = sel ? a : b;
endmodule

module Mux5Bit2To1(input[4:0] a, input[4:0] b, input sel, output[4:0] z);
	assign z = sel ? a : b;
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