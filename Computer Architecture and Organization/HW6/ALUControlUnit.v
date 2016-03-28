module ALUControlUnit(input[1:0] ALUop, input[5:0] funct, output reg[3:0] ALU_operation_signal);
    always @(ALUop, funct)
        case(ALUop)
            2'b00:
                ALU_operation_signal = 4'b0010;
            2'b01:
                ALU_operation_signal = 4'b0110;
            default: begin //rest of ALUop's because 11 isn't used
                case(funct[3:0])
                    4'b0000:
                        ALU_operation_signal = 4'b0010;
                    4'b0010:
                        ALU_operation_signal = 4'b0110;
                    4'b0100:
                        ALU_operation_signal = 4'b0000;
                    4'b0101:
                        ALU_operation_signal = 4'b0001;
                    4'b1010:
                        ALU_operation_signal = 4'b0111;
                endcase
                end
        endcase
endmodule

module ALUControlUnitTB;
    reg[1:0] ALUop;
    reg[5:0] funct;
    wire[3:0] ALU_operation_signal;
    
    ALUControlUnit aluControl(ALUop, funct, ALU_operation_signal);
    
    initial begin
        #10
            ALUop = 2'b00;
        #10
            funct = 6'b100000; //add
        #10
            ALUop = 2'b01;
        #10
            ALUop = 2'b10;
        #10
            $finish;
    end
endmodule