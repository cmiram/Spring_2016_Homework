// Multi-cycle control unit.
//
// State encoding:
//
//	State		Code
//	---------------------------
//	Fetch		0
//	Decode		1
//	Execute		2
//	AluWriteback	3
//	MemAddress	4
//	MemRead		5
//	MemWriteback	6
//	MemWrite	7
//	Branch		8
//
module ControlUnit(input clock,
		input clear,
		input[5:0] opcode,
		input[5:0] funct,
		output reg i_or_d,
		output reg mem_write,
		output reg inst_reg_write,
		output reg reg_dst,
		output reg mem_to_reg,
		output reg reg_write,
		output reg alu_src_a,
		output reg[1:0] alu_src_b,
		output reg[2:0] alu_op,
		output reg branch,
		output reg pc_write,
		output reg pc_src
        output reg jal);

	reg[3:0] state;
	reg[3:0] next;

	// Block 1 - Reset of advance state
	always @(posedge clear, negedge clock)
		if (clear)
			state <= 0;
		else
			state <= next;
	
	// Block 2 - State transitions
	always @(state, opcode, funct)
		case (state)

			// Fetch
			0:
				// Fetch -> Decode
				next <= 1;

			// Decode
			1:
				case (opcode)

					// R-Type
					6'h00:

						// Decode -> Execute
						next <= 2;

					// lw, sw
					6'h23, 6'h2b:

						// Decode -> MemAddress
						next <= 4;

					// beq
					6'h04:

						// Decode -> Branch
						next <= 8;

					// Invalid
					default:

						// Undefined
						next <= 4'bx;
				endcase

			// Execute
			2:
				// Execute -> AluWriteback
				next <= 3;

			// AluWriteback
			3:
				// AluWriteback -> Fetch
				next <= 0;

			// MemAddress
			4:
				case (opcode)

					// lw
					6'h23:

						// MemAddress -> MemRead
						next <= 5;

					// sw
					6'h2b:

						// MemAddress -> MemWrite
						next <= 7;

					// Invalid
					default:
						
						// Undefined
						next <= 4'bx;
				endcase

			// MemRead
			5:
				// MemRead -> MemWriteback
				next <= 6;

			// MemWriteback
			6:
				// MemWriteback -> Fetch
				next <= 0;

			// MemWrite
			7:
				// MemWrite -> Fetch
				next <= 0;

			// Branch
			8:
				// Branch -> Fetch
				next <= 0;
		endcase
	
	// Block 3 - Outputs
	always @(state) begin
		
		// Initially all undefined
		i_or_d = 1'bx;
		mem_write = 1'bx;
		inst_reg_write = 1'bx;
		reg_dst = 1'bx;
		mem_to_reg = 1'bx;
		reg_write = 1'bx;
		alu_src_a = 1'bx;
		alu_src_b = 2'bxx;
		alu_op = 3'bxxx;
		branch = 1'bx;
		pc_write = 1'bx;
		pc_src = 1'bx;
        jal = 1'bx;

		// Check current state
		case (state)

			// Fetch
			0: begin
				// Signals
				i_or_d = 0;
				mem_write = 0;
				inst_reg_write = 1;
				reg_write = 0;
				alu_src_a = 0;
				alu_src_b = 1;
				alu_op = 3'b010;
				pc_write = 1;
				pc_src = 0;
                jal = 0;

				// Debug
				$display("-----------------------");
				$display("Fetch");
			end

			// Decode
			1: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_write = 0;
				alu_src_a = 0;
				alu_src_b = 3;
				alu_op = 3'b010;
				branch = 0;
				pc_write = 0;
                jal = 0;

				// Debug
				$display("Decode");
			end

			// Execute
			2: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_write = 0;
				alu_src_a = 1;
				alu_src_b = 0;
				branch = 0;
				pc_write = 0;

				// ALU operation
				case (funct)
					
					// add
					6'h20: alu_op = 3'b010;

					// sub
					6'h22: alu_op = 3'b110;

					// slt
					6'h2a: alu_op = 3'b111;

					// and
					6'h24: alu_op = 3'b000;

					// or
					6'h25: alu_op = 3'b001;

					// Invalid
					default: alu_op = 3'bxxx;
				
				endcase

				// Debug
				$display("Execute");
			end

			// AluWriteback
			3: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_dst = 1;
				mem_to_reg = 0;
				reg_write = 1;
				branch = 0;
				pc_write = 0;

				// Debug
				$display("AluWriteback");
			end

			// MemAddress
			4: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_write = 0;
				alu_src_a = 1;
				alu_src_b = 2;
				alu_op = 3'b010;
				branch = 0;
				pc_write = 0;

				// Debug
				$display("MemAddress");
			end

			// MemRead
			5: begin
				// Signals
				i_or_d = 1;
				mem_write = 0;
				inst_reg_write = 0;
				reg_write = 0;
				branch = 0;
				pc_write = 0;

				// Debug
				$display("MemRead");
			end

			// MemWriteback
			6: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_dst = 0;
				mem_to_reg = 1;
				reg_write = 1;
				branch = 0;
				pc_write = 0;

				// Debug
				$display("MemWriteback");
			end

			// MemWrite
			7: begin
				// Signals
				i_or_d = 1;
				mem_write = 1;
				inst_reg_write = 0;
				reg_write = 0;
				branch = 0;
				pc_write = 0;

				// Debug
				$display("MemWrite");
			end

			// Branch
			8: begin
				// Signals
				mem_write = 0;
				inst_reg_write = 0;
				reg_write = 0;
				alu_src_a = 1;
				alu_src_b = 0;
				alu_op = 3'b110;
				branch = 1;
				pc_write = 0;
				pc_src = 1;

				// Debug
				$display("Branch");
			end
            
            9: begin
                mem_write = 1'b0;
                inst_reg_write = 1'b0;
                reg_dst = 1'bx;
                mem_to_reg = 1'bx;
                reg_write = 1'bx;
                alu_src_a = 1'bx;
                alu_src_b = 2'bxx;
                alu_op = 3'bxxx;
                branch = 1'bx;
                pc_write = 1'bx;
                pc_src = 1'bx;
                jal = 1'bx;

		endcase
	end
endmodule

