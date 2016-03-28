module RegisterFile(input rst, input clk, input wr_en, input[4:0] rd0_addr, 
                input[4:0] rd1_addr, input[4:0] wr_addr, input[31:0] wr_data, 
                output[31:0] rd0_data, output[31:0] rd1_data);
    reg[31:0] mem[31:0];
    integer i;
    
    always @(posedge rst, posedge clk)
        if (rst)
            for(i=0; i<31; i=i+1)
                mem[i] = 32'd0;
        else
            if (wr_en)
                mem[wr_addr] = wr_data;
    assign rd0_data = mem[rd0_addr];
    assign rd1_data = mem[rd1_addr];
endmodule

module RegisterFileTB;
    reg rst, clk, wr_en;
    reg[4:0] rd0_addr, rd1_addr, wr_addr;
    reg[31:0] wr_data;
    wire[31:0] rd0_data, rd1_data;
    
    RegisterFile regFile(rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data);
    
    initial begin
        rst = 1;
        #10 rst = 0;
    end
    
    initial begin
        clk = 1;
        forever
            #5 clk = ~clk;
    end
    
    initial begin
        #10
            wr_en = 1'b0;
            rd0_addr = 5'h03;
            rd1_addr = 5'h0B;
            wr_addr = 5'h03;
            wr_data = 32'h01234567;
        #10
            wr_en = 1'b1;
        #10
            wr_en = 1'b0;
            wr_addr = 5'h0B;
            wr_data = 32'hABCDEF89;
        #10
            wr_en = 1'b1;
        #10
            wr_en = 1'b0;
        #10
            $finish;
    end
endmodule