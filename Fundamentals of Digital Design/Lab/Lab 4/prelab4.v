module reg_file(input rst, input clk, input wr_en, input rd_en, input[1:0] rd0_addr, input[1:0] rd1_addr, input[1:0] wr_addr, input[8:0] wr_data, output[8:0] rd0_data, output[8:0] rd1_data);
    reg[8:0] mem[3:0];
    integer i;
    
    always @(posedge rst, negedge clk)
        if (rst)
            for(i=0; i<4; i=i+1)
                mem[i] = 9'd0;
        else
            if (wr_en)
                mem[wr_addr] = wr_data;
    assign rd0_data = rd_en ? mem[rd0_addr] : rd0_data;
    assign rd1_data = rd_en ? mem[rd1_addr] : rd1_data;
endmodule

module reg_file_tb;
    reg rst, clk, wr_en, rd_en;
    reg[1:0] rd0_addr, rd1_addr, wr_addr;
    reg[8:0] wr_data;
    wire[8:0] rd0_data,rd1_data;
    
    reg_file Reg_file(rst, clk, wr_en, rd_en, rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data);
    
    initial begin
        rst = 0;
        #10 rst = 0;
    end
    
    initial begin
    clk = 1;
    forever
        #5 clk = ~clk;
    end
    
    initial begin
        $monitor("%d rst=%b clk=%b wr_en=%b rd_en=%b rd0_addr=%d rd1_addr=%d wr_addr=%d wr_data=%d rd0_data=%d rd1_data=%d", $time, 
            rst, clk, wr_en, rd_en, rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data);
        #10
            wr_en = 1;
            rd_en = 0;
            wr_addr = 2'b01;
            wr_data = 9'd4;
        #10
            wr_addr = 2'b10;
            wr_data = 9'd77;
        #10 
            wr_en = 0;
            rd_en = 1;
            rd0_addr = 2'b01;
            rd1_addr = 2'b10;
        #10
            wr_data = 9'd45;
        #10
            wr_en = 1;
            wr_addr = 2'b01;
        #10 $finish;
    end
endmodule