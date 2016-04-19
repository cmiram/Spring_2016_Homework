module Register(input clock,
		input clear,
		input enable,
		input[31:0] in,
		output reg[31:0] out);

	always @(posedge clear, negedge clock)
		if (clear)
			out = 0;
		else if (enable)
			out = in;
endmodule

