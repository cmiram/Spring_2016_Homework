module ProgramCounter(input clk, input clr, input[31:0] next, output reg[31:0] pc);

    always @(posedge clk, posedge clr)
        if (clr)
            pc = 32'h00003000;
        else
            pc = next;
endmodule