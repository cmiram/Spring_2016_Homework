module ControlUnit(input[5:0] opcode, output reg RegDst, output reg Jump, output reg Branch, output reg MemRead,
    output reg MemtoReg, output reg MemWrite, output reg ALUsrc, output reg RegWrite, output reg[1:0] ALUop);
    
    always @(opcode)
        case(opcode)
            6'b000000: begin //R-Type Instruction
                RegDst = 1'b1;
                Jump = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUsrc = 1'b0;
                RegWrite = 1'b1;
                ALUop = 2'b10;
                end
            6'b000010: begin //Jump Instruction
                RegDst = 1'b0;
                Jump = 1'b1;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUsrc = 1'b0;
                RegWrite = 1'b0;
                ALUop = 2'b00;
                end
            6'b100011: begin //Load Word Instruction
                RegDst = 1'b0;
                Jump = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b1;
                MemtoReg = 1'b1;
                MemWrite = 1'b0;
                ALUsrc = 1'b1;
                RegWrite = 1'b1;
                ALUop = 2'b00;
                end
            6'b101011: begin //Store Word Instruction
                RegDst = 1'b0;
                Jump = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b1;
                ALUsrc = 1'b1;
                RegWrite = 1'b0;
                ALUop = 2'b00;
                end
            6'b000100: begin //Branch on Equal Instruction
                RegDst = 1'b0;
                Jump = 1'b0;
                Branch = 1'b1;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUsrc = 1'b0;
                RegWrite = 1'b0;
                ALUop = 2'b01;
                end
            default: begin //Rest of I-Type Instruction
                RegDst = 1'b0;
                Jump = 1'b0;
                Branch = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUsrc = 1'b1;
                RegWrite = 1'b1;
                ALUop = 2'b00;
                end
        endcase
endmodule

module ControlUnitTB;
    reg[5:0] opcode;
    wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    wire[1:0] ALUop;
    
    ControlUnit control(opcode, RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite, ALUop);
    
    initial begin
        #10
            opcode = 6'b000000; //R-Type
        #10
            opcode = 6'b000010; //Jump
        #10
            opcode = 6'b000100; //Branch on Equal
        #10
            opcode = 6'b100011; //Load Word
        #10
            opcode = 6'b101011; //Store Word
        #10
            opcode = 6'b001000; //Add Immediate (I-Type)
        #10
            $finish;
    end
endmodule