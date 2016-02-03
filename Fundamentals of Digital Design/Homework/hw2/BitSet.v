module BitSet(input[3:0] x, input[1:0] index, input value, output[3:0] y);
    wire[3:0] demuxResult;
    wire muxResult;
    Mux4To1 mux(1'b1, x, index, muxResult);
    wire temp;
    nor(temp, muxResult, value);
    Demux1To4 demux(temp, 1'b1, index, demuxResult);
    xor(y, x, demuxResult);    
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