module PC_Branching(input clk, input clr, input[7:0] offset, input alu_zero, output[7:0] pc);
    reg[7:0] pc;
    
    always @(posedge clk, posedge clr)
        if (clr)
            pc = 8'd0;
        else
            if (alu_zero)
                pc = pc + offset;
            else
                pc = pc + 8'd4;
endmodule