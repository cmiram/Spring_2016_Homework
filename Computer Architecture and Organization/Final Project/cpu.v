module cpu(input clk, input clr, output[31:0] instruction_out, output[31:0] read_data2_out);
    wire[31:0] pc_in;
    wire[31:0] pc_out;
    ProgramCounter pc(clk, clr, pc_in, pc_out);
   
    wire[31:0] instruction;
    wire[31:0] data_in;
    wire mem_read;
    wire mem_write;
    wire[31:0] data_out;
    wire[31:0] alu_result;
    wire[31:0] read_data_2;
   
    Memory memory(pc_out, instruction, alu_result, read_data_2, mem_read, mem_write, data_out);
   
    assign instruction_out = instruction;
   
    wire[31:0] pc_plus_4;
   
    Adder adder4(pc_out, 32'd4, pc_plus_4);
   
    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemtoReg;
    wire ALUSrc;
    wire RegWrite;
    wire[1:0] ALUop;
    ControlUnit control(instruction[31:26], RegDst, Jump, Branch, mem_read, MemtoReg, mem_write,
    ALUSrc, RegWrite, ALUop);
    
    wire[4:0] write_reg_addr;
    Mux5Bit2To1 write_reg_mux(instruction[15:11], instruction[20:16], RegDst, write_reg_addr);
    
    wire[31:0] reg_write_data;
    wire[31:0] read_data_1;
    RegisterFile RegFile(clr, clk, RegWrite, instruction[25:21], instruction[20:16], write_reg_addr, 
        reg_write_data, read_data_1, read_data_2);
        
    wire[31:0] imm_sign_extend;
    SignExtend signExtend(instruction[15:0], imm_sign_extend);
    
    wire[3:0] alu_op_signal;
    ALUControlUnit aluControl(ALUop, instruction[5:0], alu_op_signal);
    
    wire[31:0] alu_input2;
    Mux32Bit2To1 alu_input2_mux(imm_sign_extend, read_data_2, ALUSrc, alu_input2);
    
    wire alu_zero;
    ALU alu(alu_op_signal, read_data_1, alu_input2, alu_result, alu_zero);
    
    Mux32Bit2To1 data_mem_and_alu_mux(data_out, alu_result, MemtoReg, reg_write_data);
    
    wire[27:0] temp_jump_addr;
    wire [31:0] jump_addr;
    ShiftLeft26Bit jump_sl2(instruction[25:0], temp_jump_addr);
    
    assign jump_addr = {pc_plus_4[31:28], temp_jump_addr};
    
    wire[31:0] branch_adder_input2;
    ShiftLeft2 branch_sl2(imm_sign_extend, branch_adder_input2);
    
    wire[31:0] branch_target_addr;
    Adder branch_adder(pc_plus_4, branch_adder_input2, branch_target_addr);
   
    wire branch_selected;
    And bitwiseAnd(Branch, alu_zero, branch_selected);
    
    wire[31:0] non_jump_addr;
    Mux32Bit2To1 branch_mux(branch_target_addr, pc_plus_4, branch_selected, non_jump_addr);
    
    Mux32Bit2To1 jump_mux(jump_addr, non_jump_addr, Jump, pc_in);
    
    assign read_data2_out = read_data_2;
endmodule