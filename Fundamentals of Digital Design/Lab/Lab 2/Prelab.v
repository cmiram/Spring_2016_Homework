module eightbit_palu(input[7:0] a, input [7:0] b, input [1:0] sel, output[7:0] f, output ovf);
    reg f, ovf;
    always @(a, b, sel)
        case(sel)
            2'b00: {ovf, f} = a + b;
            2'b01: f = ~b;
            2'b10: f = a & b;
            2'b11: f = a | b;
        endcase
endmodule