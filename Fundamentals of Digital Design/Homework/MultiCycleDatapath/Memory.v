module Memory(input clock,
		input clear,
		input[31:0] address,
		input write,
		input[31:0] write_data,
		output reg[31:0] read_data);

	// Words 0-255 (first 1KB) represent addresses 0x400000-0x401000
	// Words 256-511 (last 1KB) represent addresses 0x10010000-0x10011000
	reg[31:0] content[511:0];
	integer i;
	
	always @(posedge clear, negedge clock)
		if (clear) begin

			// Reset content
			for (i = 0; i < 512; i = i + 1)
				content[i] = 0;

			// Initial values for instruction memory
			content[0] = 32'h00221820;	// add $3, $1, $2  <- label 'main'
			content[1] = 32'h00221822;	// sub $3, $1, $2
			content[2] = 32'h00221824;	// and $3, $1, $2
			content[3] = 32'h00221825;	// or $3, $1, $2
			content[4] = 32'h0022182a;	// slt $3, $1, $2
			content[5] = 32'h0041182a;	// slt $3, $2, $1
			content[6] = 32'h1140fff9;	// beq $10, $0, main
			content[7] = 32'h8d430000;	// lw $3, 0($10)
			content[8] = 32'h8d430004;	// lw $3, 4($10)
			content[9] = 32'had430008;	// sw $3, 8($10)
			content[10] = 32'h1000fff5;	// beq $0, $0, main
			
			// Initial values for data memory
			// Mem[0x10010000] = 100
			// Mem[0x10010004] = 200
			content[256] = 100;
			content[257] = 200;

		end else if (write &&
				address >= 32'h10010000 &&
				address < 32'h10011000) begin

			// Only write on valid addresses of data memory
			content[((address - 32'h10010000) >> 2) + 256] <= write_data;
			$display("\tMem[0x%x] = 0x%x", address, write_data);
		end

	// Read port
	always @(address)
		if (address >= 32'h400000 && address < 32'h401000)
			read_data <= content[(address - 32'h400000) >> 2];
		else if (address >= 32'h10010000 && address < 32'h10011000)
			read_data <= content[((address - 32'h10010000) >> 2) + 256];
		else
			read_data <= 0;
	
endmodule

