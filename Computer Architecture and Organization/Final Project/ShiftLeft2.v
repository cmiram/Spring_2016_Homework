module ShiftLeft2(input[31:0] in, output[31:0] out);
	assign out = in << 2;
endmodule

module ShiftLeft26Bit(input[25:0] in, output[27:0] out);
	assign out = in << 2;
endmodule