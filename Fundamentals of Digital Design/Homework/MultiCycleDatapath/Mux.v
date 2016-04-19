module Mux32Bit2To1(input[31:0] in0,
		input[31:0] in1,
		input sel,
		output[31:0] out);

	assign out = sel ? in1 : in0;

endmodule

module Mux32Bit4To1(input[31:0] in0,
		input[31:0] in1,
		input[31:0] in2,
		input[31:0] in3,
		input[1:0] sel,
		output reg[31:0] out);
	
	always @(in0, in1, in2, in3, sel)
		case (sel)
			2'b00: out <= in0;
			2'b01: out <= in1;
			2'b10: out <= in2;
			2'b11: out <= in3;
		endcase
endmodule

module Mux5Bit2To1(input[4:0] in0,
		input[4:0] in1,
        input[4:0] in2,
		input[1:0] sel,
		output[4:0] out);

	always @(in0, in1, sel)
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = 5'bxxxxx;
        endcase
endmodule

