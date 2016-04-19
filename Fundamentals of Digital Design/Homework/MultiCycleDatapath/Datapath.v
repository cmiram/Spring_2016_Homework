module Datapath(input clock,
		input clear);

	// PC register
	wire pc_enable;
	wire[31:0] pc_in;
	wire[31:0] pc_out;
	PcRegister pc_register(
			clock,
			clear,
			pc_enable,
			pc_in,
			pc_out);

	// Memory MUX
	wire[31:0] memory_mux_in0;
	wire[31:0] memory_mux_in1;
	wire memory_mux_sel;
	wire[31:0] memory_mux_out;
	Mux32Bit2To1 memory_mux(
			memory_mux_in0,
			memory_mux_in1,
			memory_mux_sel,
			memory_mux_out);

	// Connections for Memory MUX
	assign memory_mux_in0 = pc_out;

	// Memory
	wire[31:0] memory_address;
	wire memory_write;
	wire[31:0] memory_write_data;
	wire[31:0] memory_read_data;
	Memory memory(clock,
			clear,
			memory_address,
			memory_write,
			memory_write_data,
			memory_read_data);
	
	// Connections for memory
	assign memory_address = memory_mux_out;

	// Register 1
	wire register1_enable;
	wire[31:0] register1_in;
	wire[31:0] register1_out;
	Register register1(clock,
			clear,
			register1_enable,
			register1_in,
			register1_out);
	
	// Connections for Register 1
	assign register1_in = memory_read_data;

	// Register 2
	wire register2_enable;
	wire[31:0] register2_in;
	wire[31:0] register2_out;
	Register register2(clock,
			clear,
			register2_enable,
			register2_in,
			register2_out);
	
	// Connections for Register 2
	assign register2_enable = 1;
	assign register2_in = memory_read_data;

	// Register File MUX 1
	wire[4:0] register_file_mux1_in0;
	wire[4:0] register_file_mux1_in1;
	wire register_file_mux1_sel;
	wire[4:0] register_file_mux1_out;
	Mux5Bit2To1 register_file_mux1(
			register_file_mux1_in0,
			register_file_mux1_in1,
            5'b11111,
			register_file_mux1_sel,
			register_file_mux1_out);
	
	// Connections for Register File MUX 1
	assign register_file_mux1_in0 = register1_out[20:16];
	assign register_file_mux1_in1 = register1_out[15:11];
	
	// Register File MUX 2
	wire[31:0] register_file_mux2_in0;
	wire[31:0] register_file_mux2_in1;
	wire register_file_mux2_sel;
	wire[31:0] register_file_mux2_out;
	Mux32Bit2To1 register_file_mux2(
			register_file_mux2_in0,
			register_file_mux2_in1,
            pc_out,
			register_file_mux2_sel,
			register_file_mux2_out);
	
	// Connections for Register File MUX 2
	assign register_file_mux2_in1 = register2_out;

	// Register file
	wire[4:0] register_file_read_index1;
	wire[31:0] register_file_read_data1;
	wire[4:0] register_file_read_index2;
	wire[31:0] register_file_read_data2;
	wire register_file_write;
	wire[4:0] register_file_write_index;
	wire[31:0] register_file_write_data;
	RegisterFile register_file(
			clock,
			clear,
			register_file_read_index1,
			register_file_read_data1,
			register_file_read_index2,
			register_file_read_data2,
			register_file_write,
			register_file_write_index,
			register_file_write_data);

	// Connections for Register File
	assign register_file_read_index1 = register1_out[25:21];
	assign register_file_read_index2 = register1_out[20:16];
	assign register_file_write_index = register_file_mux1_out;
	assign register_file_write_data = register_file_mux2_out;

	// Register 3
	wire register3_enable;
	wire[31:0] register3_in;
	wire[31:0] register3_out;
	Register register3(clock,
			clear,
			register3_enable,
			register3_in,
			register3_out);

	// Connections for Register 3
	assign register3_enable = 1;
	assign register3_in = register_file_read_data1;

	// Register 4
	wire register4_enable;
	wire[31:0] register4_in;
	wire[31:0] register4_out;
	Register register4(clock,
			clear,
			register4_enable,
			register4_in,
			register4_out);
	
	// Connections for Register 4
	assign register4_enable = 1;
	assign register4_in = register_file_read_data2;
	assign memory_write_data = register4_out;

	// SignExtend
	wire[15:0] sign_extend_in;
	wire[31:0] sign_extend_out;
	SignExtend sign_extend(sign_extend_in,
			sign_extend_out);
	
	// Connections for SignExtend
	assign sign_extend_in = register1_out[15:0];

	// ShiftLeft
	wire[31:0] shift_left_in;
	wire[31:0] shift_left_out;
	ShiftLeft shift_left(shift_left_in,
			shift_left_out);
	
	// Connections for ShiftLeft
	assign shift_left_in = sign_extend_out;

	// ALU MUX 1
	wire[31:0] alu_mux1_in0;
	wire[31:0] alu_mux1_in1;
	wire alu_mux1_sel;
	wire[31:0] alu_mux1_out;
	Mux32Bit2To1 alu_mux1(
			alu_mux1_in0,
			alu_mux1_in1,
			alu_mux1_sel,
			alu_mux1_out);
	
	// Connections for ALU MUX 1
	assign alu_mux1_in0 = pc_out;
	assign alu_mux1_in1 = register3_out;

	// ALU MUX 2
	wire[31:0] alu_mux2_in0;
	wire[31:0] alu_mux2_in1;
	wire[31:0] alu_mux2_in2;
	wire[31:0] alu_mux2_in3;
	wire[1:0] alu_mux2_sel;
	wire[31:0] alu_mux2_out;
	Mux32Bit4To1 alu_mux2(
			alu_mux2_in0,
			alu_mux2_in1,
			alu_mux2_in2,
			alu_mux2_in3,
			alu_mux2_sel,
			alu_mux2_out);
	
	// Connections for ALU MUX 2
	assign alu_mux2_in0 = register4_out;
	assign alu_mux2_in1 = 4;
	assign alu_mux2_in2 = sign_extend_out;
	assign alu_mux2_in3 = shift_left_out;

	// ALU
	wire[31:0] alu_op1;
	wire[31:0] alu_op2;
	wire[2:0] alu_f;
	wire[31:0] alu_result;
	wire alu_zero;
	Alu alu(alu_op1,
			alu_op2,
			alu_f,
			alu_result,
			alu_zero);
	
	// Connections for ALU
	assign alu_op1 = alu_mux1_out;
	assign alu_op2 = alu_mux2_out;
	
	// Register 5
	wire register5_enable;
	wire[31:0] register5_in;
	wire[31:0] register5_out;
	Register register5(clock,
			clear,
			register5_enable,
			register5_in,
			register5_out);
	
	// Connections for Register 5
	assign register5_enable = 1;
	assign register5_in = alu_result;
	assign pc_mux_in1 = register5_out;
	assign register_file_mux2_in0 = register5_out;
	assign memory_mux_in1 = register5_out;

	// AND gate
	wire and_gate_in1;
	wire and_gate_in2;
	wire and_gate_out;
	and and_gate(and_gate_out,
			and_gate_in1,
			and_gate_in2);
	
	// Connections for AND gate
	assign and_gate_in2 = alu_zero;
	
	// OR gate
	wire or_gate_in1;
	wire or_gate_in2;
	wire or_gate_out;
	or or_gate(or_gate_out,
			or_gate_in1,
			or_gate_in2);
	
	// Connections for OR gate
	assign or_gate_in2 = and_gate_out;
	assign pc_enable = or_gate_out;

	// PC MUX
	wire[31:0] pc_mux_in0;
	wire[31:0] pc_mux_in1;
	wire pc_mux_sel;
	wire[31:0] pc_mux_out;
	Mux32Bit2To1 pc_mux(
			pc_mux_in0,
			pc_mux_in1,
			pc_mux_sel,
			pc_mux_out);

	// Connections for PC MUX
	assign pc_mux_in0 = alu_result;
	assign pc_mux_in1 = register5_out;
    
    wire[27:0] intermediateShift;
    ShiftLeft2 sl2(instruction[25:0], intermediateShift);
    
    wire[31:0] jumpTarget;
    assign jumpTarget = {pc_out[31:30], intermediateShift};
    
    Mux32Bit2To1 JumpAndLinkMux(pc_mux_out, jumpTarget, jal, pc_in);

	// Control unit
	wire[5:0] control_unit_opcode;
	wire[5:0] control_unit_funct;
	wire control_unit_i_or_d;
	wire control_unit_mem_write;
	wire control_unit_inst_reg_write;
	wire control_unit_reg_dst;
	wire control_unit_mem_to_reg;
	wire control_unit_reg_write;
	wire control_unit_alu_src_a;
	wire[1:0] control_unit_alu_src_b;
	wire[2:0] control_unit_alu_op;
	wire control_unit_branch;
	wire control_unit_pc_write;
	wire control_unit_pc_src;
    wire control_unit_jal;
	ControlUnit control_unit(
			clock,
			clear,
			control_unit_opcode,
			control_unit_funct,
			control_unit_i_or_d,
			control_unit_mem_write,
			control_unit_inst_reg_write,
			control_unit_reg_dst,
			control_unit_mem_to_reg,
			control_unit_reg_write,
			control_unit_alu_src_a,
			control_unit_alu_src_b,
			control_unit_alu_op,
			control_unit_branch,
			control_unit_pc_write,
			control_unit_pc_src,
            control_unit_jal);
	
	// Connections for control unit
	assign control_unit_opcode = register1_out[31:26];
	assign control_unit_funct = register1_out[5:0];
	assign memory_mux_sel = control_unit_i_or_d;
	assign memory_write = control_unit_mem_write;
	assign register1_enable = control_unit_inst_reg_write;
	assign register_file_mux1_sel = control_unit_reg_dst;
	assign register_file_mux2_sel = control_unit_mem_to_reg;
	assign register_file_write = control_unit_reg_write;
	assign alu_mux1_sel = control_unit_alu_src_a;
	assign alu_mux2_sel = control_unit_alu_src_b;
	assign alu_f = control_unit_alu_op;
	assign and_gate_in1 = control_unit_branch;
	assign or_gate_in1 = control_unit_pc_write;
	assign pc_mux_sel = control_unit_pc_src;
    assign jal = control_unit_jal;

	// Debug info for current instruction, activated when the content of the
	// instruction register is updated.
	always @(negedge clock) begin
		if (!clear && register1_enable) begin

			// Print PC and instruction word
			$display("\tPC %x, Instruction %x",
					memory_address,
					memory_read_data);
			
			// Check opcode
			case (memory_read_data[31:26])

			// R-Type
			6'h00:
				// Check funct
				case (memory_read_data[5:0])

					// add
					6'h20: $display("\tInstruction 'add'");

					// sub
					6'h22: $display("\tInstruction 'sub'");

					// slt
					6'h2a: $display("\tInstruction 'slt'");

					// and
					6'h24: $display("\tInstruction 'and'");

					// or
					6'h25: $display("\tInstruction 'or'");

					// Invalid
					default: $display("\tInvalid instruction");
				endcase

			// lw
			6'h23: $display("\tInstruction 'lw'");

			// sw
			6'h2b: $display("\tInstruction 'sw'");

			// beq
			6'h04: $display("\tInstruction 'beq'");

			// Invalid
			default: $display("\tInvalid instruction");

			endcase
		end
	end

endmodule

