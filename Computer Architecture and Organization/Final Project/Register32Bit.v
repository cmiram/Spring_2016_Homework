module Register32Bit(input clk, input rst, input load_en, input[31:0] write_data, output reg[31:0] data);
    
    always @(posedge clk, posedge rst)
        if (rst)
            data = 32'd0;
        else
            if (load_en)
                data = write_data;
endmodule

module Register32BitTB;
    reg clk, rst, load_en;
    reg[31:0] write_data;
    wire[31:0] data;
    
    Register32Bit register(clk, rst, load_en, write_data, data);
    
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
            load_en = 1'b0;
            write_data = 32'hABCD1234;
        #10
            load_en = 1'b1;
        #10
            $finish;
    end
endmodule