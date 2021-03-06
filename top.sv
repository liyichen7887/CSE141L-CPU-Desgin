// CSE141L Win2018    in-class demo
// top-level design connects all pieces together
import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

  // list of interconnecting wires/buses w/ respective bit widths 
  wire    RegRead;
  wire    RegWrite;
  wire 	  AccWrite;
  wire    Halt;
  wire    ReadMem;
  wire    WriteMem;
  wire    LUT_Pc;
  wire    LUT_Mem;
  wire    ov_0;
  wire    jump_bit;

  logic    overflow_bit;
  logic    overflow_bit_next;
  logic[1:0] state = 0;
  logic[3:0] accIndex = 'd0000;

	logic [7:0] RF [2**4]; 

  logic [8:0] inst_rom [2**8];

  wire signed[7:0] bamt;	    // PC jump
  wire[7:0] PC;				    // program counter
  wire[8:0] inst;			    // machine code
  
  wire[7:0] dm_out,			    // data memory
            dm_in,			   
            dm_adr,
	    Lut_dm_adr;
  wire[7:0] in_a,			    // alu inputs
            in_b,			   
			      rslt,               // alu output
            acc,	            // reg_file outputs
			      do_b;			   
  wire[7:0] rf_din;	            // reg_file input
  wire[4:0] opcode;	                // opcode
  wire[3:0] operand;

  // wire      z;	                // alu zero flag
  // logic     rf_we;              // reg_file write enable
  // wire      ldr,			    // load mode (mem --> reg_file)
  //           str;			    // store (reg_file --> mem)
  assign    opcode    = inst[8:4];
  assign    operand   = inst[3:0];
  assign    dm_in = acc;	    // rf ==> dm
  assign    in_a  = acc; 		// rf ==> ALU
  
  // always_comb case (op)
  //   kLDR, kCLR, kACC, kACI: rf_we = 1;
  //   default: rf_we = 0;
  // endcase
// load: rf data input from mem; else: from ALU out 
  assign    rf_din = ReadMem? dm_out : rslt;
  assign    dm_adr = LUT_Mem? Lut_dm_adr : rslt;
// select immediate or rf for second ALU input
// assign    in_b  = op==kACI? -1 : do_b; 
// PC branch values
 //  logic[1:0] lutpc_ptr;
 //  always_comb case(op)
 //    kBZR: lutpc_ptr = 2;	     // relative
	// kBZA: lutpc_ptr = 1;	     // absolute
	// default: lutpc_ptr = 0;	     // biz-as-usual
 //  endcase 					   

  LUT_Control_Flow lut_pc (
    .index(operand),
    .read_enable(LUT_Pc),
    .addr(bamt)
    );
  // lut_pc lp1(				     // maps 2 bits to 8
  //   .ptr  (lutpc_ptr),		    
  // 	.dout (bamt));	             // branch distance in PC

  IF pc(						 // program counter
    .abs(bamt) ,        // from lut_pc
    .abs_jmp(jump_bit),
    .reset, 
    .Halt(Halt),	
    .clk,
    .state,
    .PC 
    );					     // to PC module

  InstROM inst_fetch(
    .InstAddress(PC),
    .inst(inst),
    .inst_rom
    );

  control ctrl(
    .opcode,
    .RegRead,
    .RegWrite,
    .AccWrite,
    .Halt,
    .ReadMem,
    .WriteMem,
    .LUT_Pc,
    .LUT_Mem,
    .ov_0
    );

  assign done = (state == 0 && PC == 66) ||
                (state == 1 && PC == 120) || 
                (state == 2 && PC == 170); // store result & hit done flag

  // ls_dec  dc1(				     // load and store decode
  //   .op  ,
  // 	.str ,					     // store turns on memory write enable
  // 	.ldr					     // load turns on reg_file write enable
  // );

  reg_file rf(						 // reg file -- one write, two reads
   .clk,
   .rs_addr_i(accIndex),			 // accumulator
   .rt_addr_i(operand),       // reg to be read from
   .write_addr_i(operand),    // reg to be written in
   .acc_wen(AccWrite),		 // acc write enable
   .reg_wen(RegWrite),		 // reg write enable
   .reg_read(RegRead),
   .write_data_i(rf_din),       // data to be written
   .rs_val_o(acc),              // to ALU
   .rt_val_o(do_b),
   .RF  						 // to ALU immediate input switch
  );

	

  alu au1(						 // execution (ALU) unit
    .acc,			
    .rs(do_b) ,						 // reg file output or lookup table output
    .ov_i(overflow_bit),           // overflow in
    .op_i(inst),
    .result_o(rslt),						 // alu output
    .ov_o(overflow_bit_next),	 // carry out 
    .jump_bit 
    );						 

  LUT_Memory_Addr lm(					 // lookup table for data mem address
    .index(operand),
    .LUT_Memory_Read(LUT_Mem),
    .addr(Lut_dm_adr)
  );

  data_mem dm1(						 // data memory
   .clk,
   .DataAddress(dm_adr),         // from LUT
   .ReadMem,				        // only time to READ = ldr
   .WriteMem,
   .DataIn(dm_in),				 // data to store (from reg_file)
   .DataOut(dm_out));				 // data out (for loads)

 always@(posedge clk) begin
        if(reset == 1 || ov_0 ==1)
            overflow_bit <= 1'b0;
        else
            overflow_bit <= overflow_bit_next;
 end

 always@(posedge done) begin
	if(state == 2) state <=0;
	else 				state <= state + 1;
 end
endmodule