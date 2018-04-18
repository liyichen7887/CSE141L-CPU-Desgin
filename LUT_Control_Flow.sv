module LUT_Control_Flow (
	input  [3:0]	index,
	input 			read_enable,
	output logic [7:0]	 addr  
	);

always_comb
	case(index)
		// p1
		0'b0000: addr = 8'd34;
		0'b0001: addr = 8'd30;
		0'b0010: addr = 8'd16;
		0'b0011: addr = 8'd63;
		0'b0100: addr = 8'd55;
		0'b0101: addr = 8'd41;

		//p2
		0'b1000: addr = 8'd87;
		0'b1001: addr = 8'd94;
		0'b1010: addr = 8'd112;
		0'b1011: addr = 8'd109;
		0'b1100: addr = 8'd119;
		
		//p3
		0'b1101: addr = 8'd132;
		0'b1110: addr = 8'd138;
		0'b1111: addr = 8'd160;
		0'b0110: addr = 8'd165;
		0'b0111: addr = 8'd169;
		default: addr = 8'd0;
	endcase // index

endmodule // LUT_Control_Flow