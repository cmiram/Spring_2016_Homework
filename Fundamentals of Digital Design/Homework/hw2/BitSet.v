module BitSet(input[3:0] x, input[1:0] index, input value, output[3:0] y);
    wire[3:0] demuxResult;
    wire muxResult, temp;
    Mux4To1 mux(1'b1, x, index, muxResult);
    xor(temp, muxResult, value);
    Demux1To4 demux(1'b1, temp, index, demuxResult);
    xor(y[0], x[0], demuxResult[0]);
    xor(y[1], x[1], demuxResult[1]);
    xor(y[2], x[2], demuxResult[2]);
    xor(y[3], x[3], demuxResult[3]);
endmodule

module Demux1To4(input e, input x, input[1:0] s, output[3:0] y);
    reg y;
    always @(e, x, s)
        if(e)
            case(s)
                0: y = {3'b000, x};
                1: y = {2'b00, x, 1'b0};
                2: y = {1'b0, x, 2'b00};
                3: y = {x, 3'b000};
            endcase
        else
            y = 0;
endmodule

module Mux4To1(input e, input[3:0] x, input[1:0] s, output y);
    assign y = x[s] & e;
endmodule

module BitSet_tb;
    reg[3:0] x;
    reg[1:0] index;
    reg value;
    wire[3:0] y;
    
    BitSet bitSet(x, index, value, y);
    initial begin
        $monitor("%d x=%b%b%b%b index=%b%b value=%b --> y=%b%b%b%b", $time, x[3], x[2], x[1], x[0],
            index[1], index[0], value, y[3], y[2], y[1], y[0]);
        #10
            x=4'b0000;
            index=2'b00;
            value=1'b1;
        #10
            x=4'b1111;
            index=2'b01;
            value=1'b0;
        #10
            x=4'b1010;
            index=2'b10;
            value=1'b0;
        #10
            x=4'b1110;
            index=2'b11;
            value=1'b1;
        #10 $finish;
    end
endmodule