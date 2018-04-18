module LUT_Memory_Addr (
	input  [3:0]	index,
	input 			LUT_Memory_Read,
	output logic [7:0]	 addr  
	);

always_comb
	case(index)
		// program 1
		0'b0000: addr = 8'd1;
		0'b0001: addr = 8'd2;
		0'b0010: addr = 8'd3;
		0'b0011: addr = 8'd4;
		0'b0100: addr = 8'd5;
		
		// program 2
		0'b0101: addr = 8'd7;

		// program 3
		0'b1011: addr = 8'd128;
		0'b1100: addr = 8'd127;
		default: addr = 8'd0;
	endcase // index

endmodule // LUT_Control_Flow