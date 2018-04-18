import definitions::*;

module control 
	(input        [4:0]  opcode,
	output logic		RegRead,
	output logic 		RegWrite,
	output logic		AccWrite,
    output logic     	Halt,
    output logic        ReadMem,
    output logic        WriteMem,
    output logic        LUT_Pc,
    output logic 		LUT_Mem,
    output logic        ov_0
    );

    always_comb	begin
    	case(opcode)
    		MOV: 
	    		begin
	    			RegRead = 1;
	    			RegWrite = 0;
					AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	IMOV: 
	    		begin
	    			RegRead = 0;
	    			RegWrite = 0;
				AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	MOVTO: 
	    		begin
	    			RegRead = 1;
				AccWrite = 0;
	    			RegWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	CMP: 
	    		begin
	    			RegRead = 1;
	    			RegWrite = 0;
					AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	ICMP: 
	    		begin
	    			RegRead = 0;
	    			RegWrite = 0;
				AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	LSL: 
	    		begin
	    			RegRead = 1;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	ILSL: 
	    		begin
	    			RegRead = 0;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	RSL: 
	    		begin
	    			RegRead = 1;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	IRSL: 
	    		begin
	    			RegRead = 0;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	AND: 
	    		begin
	    			RegRead = 1;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	OR: 
	    		begin
	    			RegRead = 1;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	XOR: 
	    		begin
	    			RegRead = 1;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	ADD: 
	    		begin
	    			RegRead = 1;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	IADD: 
	    		begin
	    			RegRead = 0;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	SUB: 
	    		begin
	    			RegRead = 1;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	ISUB: 
	    		begin
	    			RegRead = 0;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	MOD: 
	    		begin
	    			RegRead = 1;
					AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	LDR: 
	    		begin
	    			RegRead = 0;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 1;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 1;
	    			ov_0 = 0;
	    		end
		
		RLDR: 
	    		begin
	    			RegRead = 1;
				AccWrite = 1;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 1;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	STR: 
	    		begin
	    			RegRead = 1;
					AccWrite = 0;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 1;
	    			LUT_Pc = 0;
	    			LUT_Mem = 1;
	    			ov_0 = 0;
	    		end

	    	B: 
	    		begin
	    			RegRead = 0;
					AccWrite = 0;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 1;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	BEQ: 
	    		begin
	    			RegRead = 0;
				AccWrite = 0;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 1;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	BLE: 
	    		begin
	    			RegRead = 0;
				AccWrite = 0;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 1;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	BGE: 
	    		begin
	    			RegRead = 0;
				AccWrite = 0;
	    			RegWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 1;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	LDROV: 
	    		begin
	    			RegRead = 0;
	    			RegWrite = 0;
					AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	CLROV: 
	    		begin
	    			RegRead = 0;
	    			RegWrite = 0;
					AccWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 1;
	    		end
	    	ABS: 
	    		begin
	    			RegRead = 1;
	    			RegWrite = 0;
					AccWrite = 1;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end

	    	default:
	    		begin
	    			RegRead = 0;
	    			RegWrite = 0;
					AccWrite = 0;
	    			Halt = 0;
	    			ReadMem = 0;
	    			WriteMem = 0;
	    			LUT_Pc = 0;
	    			LUT_Mem = 0;
	    			ov_0 = 0;
	    		end
	    	endcase // opcode
	    end
	    endmodule // control_unit
