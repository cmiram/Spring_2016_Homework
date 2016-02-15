module RegisterFile32Bit(input clk, input clr, input write1, input[31:0] write_data1, input[4:0] write_index1,
                            input write2, input[31:0] write_data2, input[4:0] write_index2,  input[4:0] read_index,
                            output[31:0] read_data);
    reg[31:0] mem[31:0];
    integer i;
    
    always @(posedge clr, negedge clk)
        if (clr)
            for(i=0; i<32; i=i+1)
                mem[i] = 32'd0;
        else begin
            if(write1)
                mem[write_index1] = write_data1;
            if (write2)
                if (~(write_index1 == write_index2))
                    mem[write_index2] = write_data2;
        end
    assign read_data = mem[read_index];
endmodule

module RegisterFile32Bit_tb;
    reg clk, clr, write1, write2;
    reg[4:0] write_index1, write_index2, read_index;
    reg[31:0] write_data1, write_data2;
    wire[31:0] read_data;
    RegisterFile32Bit registerFile32Bit(clk, clr, write1, write_data1, write_index1, write2, write_data2, write_index2,
                                            read_index, read_data);
                                            
    initial begin
        clr = 1;
        #10 clr = 0;
    end
    
    initial begin
        clk = 0;
        forever
            #5 clk = ~clk;
    end
    
    initial begin
        $monitor("%d time=%b clr=%b write1=%b write_index1=%d write_data1=%d write2=%b write_index2=%d write_data2=%d read_index=%d read_data=%d", 
                    $time, clk, clr, write1, write_index1, write_data1, write2, write_index2, write_data2, read_index, read_data);
        #10
            write1 = 1'b1;
            write_index1 = 5'd2;
            write_data1 = 32'd20;
            write2 = 1'b1;
            write_index2 = 5'd3;
            write_data2 = 32'd45;
        #10
            write1 = 1'b0;
            write2 = 1'b0;
            read_index = 5'd2;
        #10
            read_index = 5'd3;
        #10
            read_index = 5'd2;
        #10
            write1 = 1'b1;
            write_data1 = 32'd35;
            write2 = 1'b1;
            write_index2 = 5'd2;
            write_data2 = 32'd10;
        #10 $finish;
    end
endmodule