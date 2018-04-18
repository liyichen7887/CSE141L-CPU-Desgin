// testbench for A*B*C
// CSE141L  Win 2018  Program 1 
module program1_tb;
  bit         clk, 				 // to DUT
              reset = 1;
  wire        done;				 // done flag from DUT
  logic[ 7:0] a,
              b,
              c;
  logic[15:0] p;				 // p = a*b*c
 logic [8:0] inst;
 logic [8:0] inst_rom [2**8];
logic[7:0] PC;
logic [7:0] RF [2**4];
logic [4:0] opcode;
logic jump_bit;
logic [7:0] rf_din; 
logic [7:0] rslt;
logic [7:0] do_b; 
logic overflow_bit;
logic overflow_bit_next, ov_o, ov_i;

  
  top mpy(.*);   			 // DUT -- connects clk, init, done

assign inst_rom = mpy.inst_fetch.inst_rom;
	assign inst = mpy.inst;
	assign PC = mpy.pc.PC;
	assign RF = mpy.RF;	
	assign opcode = mpy.opcode;
	assign jump_bit = mpy.jump_bit;
	assign rf_din = mpy.rf_din;
	assign rslt = mpy.rslt;
	assign do_b = mpy.do_b;
	assign overflow_bit = mpy.overflow_bit;
	assign overflow_bit_next = mpy.overflow_bit_next;
	assign ov_o = mpy.au1.ov_o; 
	assign ov_i = mpy.au1.ov_i; 
	

  initial begin
// start first of two problems
        a               =  2;
	b               = 3;
	c               = 4;
	mpy.dm1.my_memory[1] =  a;        // initialize DUT data memory
	mpy.dm1.my_memory[2] =  b;
	mpy.dm1.my_memory[3] =  c;
// compute what the product should be
// under Verilog rules, only the lower 16 bits will be retained
	$display(" %d*%d*%d",a,b,c);
	p = mpy.dm1.my_memory[1]	* mpy.dm1.my_memory[2] * mpy.dm1.my_memory[3];
	#20ns reset = 0;
    wait(done);
// diagnostics: compare a*b*c against what the DUT computes 
	$display ("prod= %d  %d",p,{mpy.dm1.my_memory[4],mpy.dm1.my_memory[5]});
    $displayh("prod=0x%h 0x%h",p,{mpy.dm1.my_memory[4],mpy.dm1.my_memory[5]});
// start a second problem -- we could/should randomize in future runs
	a = 12;
	b = 14;
	c = 4;
	mpy.dm1.my_memory[1] =  a;        // initialize DUT data memory
	mpy.dm1.my_memory[2] =  b;
	mpy.dm1.my_memory[3] =  c;
	reset = 1;
	$display(" %d*%d*%d",a,b,c);
	p = mpy.dm1.my_memory[1]	* mpy.dm1.my_memory[2] * mpy.dm1.my_memory[3];
	#20ns reset = 0;
    wait(done);
	$display ("prod= %d  %d",p,{mpy.dm1.my_memory[4],mpy.dm1.my_memory[5]});
    $displayh("prod=0x%h 0x%h",p,{mpy.dm1.my_memory[4],mpy.dm1.my_memory[5]});
    $stop;
  end
// irrespective of what you read in textbooks and online, this is the preferred clock syntax
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

endmodule 