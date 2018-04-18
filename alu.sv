// Create Date:     2017.05.05
// Latest rev date: 2017.10.26
// Created by:      J Eldon
// Design Name:     CSE141L
// Module Name:     ALU (Arithmetic Logical Unit)


//This is the ALU module of the core, op_code_e is defined in definitions.v file
// Includes new enum op_mnemonic to make instructions appear literally on waveform.
import definitions::*;

module alu (input signed [7:0]       acc,	 // pass in the accumulator
    input  signed [7:0]       rs,     // pass in the input register
    input              ov_i ,	 // shift-in
    input  [8:0]       op_i	,	 // instruction / opcode
    output logic  [7:0] result_o,	 // rslt
    output logic       ov_o,   // carry out bit / overflow bit
    output logic       jump_bit);  

op_code op3; 	                     // type is op_code, as defined
assign op3 = op_code'(op_i[8:4]);        // map 3 MSBs of op_i to op3 (ALU), cast to enum

always_comb								  // no registers, no clocks
begin
    result_o   = 'd0;                     // default or NOP result
    ov_o       = ov_i;
    jump_bit   = 'd0;
    case (op3)  						      // using top 3 bits as ALU instructions
        MOV: result_o = rs;					  // Mov from register to accumulator
        IMOV: result_o = rs;
        //HALT: // handled in top level / decode -- not needed in ALU
        MOVTO: result_o = acc;           // move the content of the acc to the register
            //CLR: result_o = 8'h00;				  // clear (output = 0)
            CMP: begin
                if (acc < rs) 
                    result_o = 'd0;
                else if (acc == rs)
                    result_o = 'd1;
                else result_o = 'd2;
            end
            ICMP: begin
                if (acc == rs) 
                    result_o = 'd1;
                else 
                    result_o = 'd0;
            end
            LSL: result_o = acc << rs;
            ILSL: result_o = acc << rs;
            RSL: result_o = acc >> rs;
            IRSL: result_o = acc >> rs;
            AND: result_o = acc & rs;
            XOR: result_o = acc ^ rs;
            ADD: begin {ov_o, result_o} = acc + rs + ov_i;
			
		end 
            IADD:begin {ov_o, result_o} = acc + rs + ov_i;
		end
            SUB: begin
                if (acc > rs)
                    {ov_o, result_o} = acc - rs + ov_i;
                else 
                    {ov_o, result_o} = rs - acc + ov_i;
                end
            ISUB: {ov_o, result_o} = acc - rs + ov_i;
            MOD: result_o = acc % rs;
            LDR: result_o = rs;
	    RLDR: begin
			result_o = rs;
			//$display("what is result_o",,,result_o);
			//$display("what is acc",,,acc);
			//$display("what is rs",,,rs);
		 end
            STR: result_o = rs;
            B:   begin 
            		result_o = rs;
            		jump_bit = 'd1;
        	end
        BEQ: begin
            if (acc == 'd1) 
                jump_bit = 'd1;
            else 
                jump_bit = 'd0; 
            result_o = rs;
        end
        BLE:
        begin
            jump_bit = 'd0;
            if (acc < 'd2)
                jump_bit = 'd1;
            result_o = rs;
        end
        BGE:
        begin
            jump_bit = 'd0;
            if (acc > 'd0)
                jump_bit = 'd1;
            result_o = rs;
        end
        LDROV: result_o = ov_o;
        CLROV: begin
            ov_o = 'd0; 
            result_o = ov_o;
        end
        OR:  result_o = rs | acc;
        ABS: result_o = (rs < 0) ? -rs : rs;

	default:;
    endcase
end

endmodule 
