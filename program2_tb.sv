module program2_tb;
  bit         clk, 
              reset = 1;
  wire        done;
  logic[ 7:0] dat_ram[96];	         
  logic[ 7:0] ct;
  logic [8:0] inst;
 logic [8:0] inst_rom [2**8];
logic[7:0] PC;
logic [7:0] RF [2**4];
logic [4:0] opcode;
logic jump_bit;
logic [7:0] rf_din; 
logic [7:0] rslt;
logic [7:0] do_b; 

  top strm(.*);

assign inst_rom = strm.inst_fetch.inst_rom;
	assign inst = strm.inst;
	assign PC = strm.pc.PC;
	assign RF = strm.RF;	
	assign opcode = strm.opcode;
	assign jump_bit = strm.jump_bit;
	assign rf_din = strm.rf_din;
	assign rslt = strm.rslt;
	assign do_b = strm.do_b;

  initial begin
    ct              = 0;
    dat_ram[6]      = 4'b1111;			// pattern to match
	strm.dm1.my_memory[6] = dat_ram[6];
	for(int i=32;i<96;i++) begin
	  dat_ram[i]      =  $random;
	  strm.dm1.my_memory[i] =  dat_ram[i];
//	  for(int j=0;j<5;j++) begin
      if(dat_ram[i][3:0]==dat_ram[6] ||
         dat_ram[i][4:1]==dat_ram[6] ||
         dat_ram[i][5:2]==dat_ram[6] ||
         dat_ram[i][6:3]==dat_ram[6] ||
         dat_ram[i][7:4]==dat_ram[6])
		 begin
           ct++;
           $display("bench",,,ct,,,i);      
	     end
	end
	#20ns reset = 0;
    wait(done);
    #20ns $display(ct,,,strm.dm1.my_memory[7]);
    if(ct==strm.dm1.my_memory[7]) $display("program 2 success");
	#20ns reset      = 1;
    ct              = 0;
    dat_ram[6]      = 4'b0101;			// pattern to match
	strm.dm1.my_memory[6] = dat_ram[6];
	for(int i=32;i<96;i++) begin
	  dat_ram[i]      =  $random>>8;
	  strm.dm1.my_memory[i] =  dat_ram[i];
//	  for(int j=0;j<5;j++) begin
      if(dat_ram[i][3:0]==dat_ram[6] ||
         dat_ram[i][4:1]==dat_ram[6] ||
         dat_ram[i][5:2]==dat_ram[6] ||
         dat_ram[i][6:3]==dat_ram[6] ||
         dat_ram[i][7:4]==dat_ram[6])
		 begin
           ct++;
           $display("bench",,,ct,,,i);      
	     end
	end
	#20ns reset = 0;
    wait(done);
    #20ns $display(ct,,,strm.dm1.my_memory[7]);
    #10ns $stop;
  end
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

endmodule 