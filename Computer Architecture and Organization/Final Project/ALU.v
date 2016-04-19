module ALU(input[3:0] control, input signed[31:0] op1, input signed[31:0] op2, output reg signed[31:0] ALUresult, output reg zero);
    always @(control, op1, op2)
        case(control)
            4'b0010: begin
                ALUresult = op1 + op2;
                zero = (ALUresult) == (32'd0);
                end
            4'b0110: begin
                ALUresult = op1 - op2;
                zero = (ALUresult) == (32'd0);
                end
            4'b0111: begin
                ALUresult = (op1 < op2) ? 1 : 0;
                zero = (ALUresult) == (32'd0);
                end
        endcase
endmodule

module ALUTB;
    reg[3:0] control;
    reg[31:0] op1, op2;
    wire[31:0] ALUresult;
    wire zero;
    
    ALU alu(control, op1, op2, ALUresult, zero);
    
    initial begin
        #10
            control = 4'b0010;
            op1 = 32'd5;
            op2 = 32'd40;
        #10
            control = 4'b0110;
        #10
            op1 = 32'd40;
        #10
            control = 4'b0111;
        #10
            op2 = 32'd45;
        #10
            $finish;
    end
endmodule