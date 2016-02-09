module EightBitAlu(input[7:0] a, input[7:0] b, input[2:0] sel, output[7:0] f, output ovf, output take_branch);
    reg[7:0] f;
    reg ovf, take_branch;
    always @(a, b, sel)
    begin
        f = 0;
        ovf = 0;
        take_branch = 0;
        case(sel)
            0:  begin
                f = a + b;
                ovf = (a[7] ~^ b[7]) & (a[7] ^ f[7]);
                end
            1:  f = ~b;
            2:  f = a & b;
            3:  f = a | b;
            4:  f = a >> 1;
            5:  f = a << 1;
            6:  take_branch = a == b;
            7:  take_branch = ~(a == b);
                endcase
    end
endmodule

module EightBitAlu_tb;
    reg[7:0] a, b;
    reg[2:0] sel;
    wire[7:0] f;
    wire ovf, take_branch;
    EightBitAlu eightBitAlu(a, b, sel, f, ovf, take_branch);
    
    initial begin
        $monitor("%d a=%b%b%b%b%b%b%b%b b=%b%b%b%b%b%b%b%b sel=%b%b%b f=%b%b%b%b%b%b%b%b ovf=%b take_branch=%b", $time,
            a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0], b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0], sel[2],
            sel[1], sel[0], f[7], f[6], f[5], f[4], f[3], f[2], f[1], f[0], ovf, take_branch);
        #10
            a = 8'b11010101;
            b = 8'b10101010;
            sel = 3'd0;
        #10
            a = 8'b00000000;
            b = 8'b11000101;
            sel = 3'd1;
        #10
            a = 8'b10011011;
            b = 8'b01001110;
            sel = 3'd2;
        #10
            a = 8'b01100010;
            b = 8'b10100010;
            sel = 3'd3;
        #10
            a = 8'b01011010;
            b = 8'b00000001;
            sel = 3'd4;
        #10
            a = 8'b10011010;
            b = 8'b00110101;
            sel = 3'd5;
        #10
            a = 8'b10101001;
            b = 8'b10100101;
            sel = 3'd6;
        #10
            a = 8'b11000110;
            b = 8'b10111010;
            sel = 3'd7;
        #10 $finish;
    end
endmodule