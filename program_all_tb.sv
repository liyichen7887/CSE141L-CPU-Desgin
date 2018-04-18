// Master Testbench -- runs all three programs in succession
// Winter 2018   CSE141L
module program_all_tb();
  logic       clk, 					    // to your DUT
              reset = 1;
  wire        done;					    // from your DUT
  logic[15:0] p;
  top 	pa1(.*);					// personalize to your design
  logic[7:0]  a, b, c;                  // program 1 mpy operands
  logic signed [7:0]  dat_ram[256];
  bit[7:0]   ct;						// program 2 where's Waldo count
  logic signed[ 8:0] dist1,	            // program 3 distances
                     dist2;
  logic       [ 7:0] ct3;
  logic[7:0] PC;
  int  seed  = 7473217;			            // change to vary "random" operands
  logic [8:0] inst;
 logic [8:0] inst_rom [2**8];
//  logic[7:0] test;

logic [7:0] RF [2**4];
logic jump_bit;
logic [7:0] rf_din; 
logic [7:0] rslt;
logic [7:0] do_b; 
logic [1:0] state;


assign inst_rom = pa1.inst_fetch.inst_rom;
	assign inst = pa1.inst;
	assign PC = pa1.pc.PC;
	assign RF = pa1.RF;	
	assign opcode = pa1.opcode;
	assign jump_bit = pa1.jump_bit;
	assign rf_din = pa1.rf_din;
	assign rslt = pa1.rslt;
	assign do_b = pa1.do_b;
	assign state = pa1.state;
	
  initial begin

// start first multiplication
    	a               =  0;
	b               = 0;
	c               =  0;
	pa1.dm1.my_memory[1] =  a;           // initialize DUT data memory
	pa1.dm1.my_memory[2] =  b;		    // personalize these path names
	pa1.dm1.my_memory[3] =  c;			//   to your design
// compute what the product should be
// under Verilog rules, only the lower 16 bits will be retained
    $display("program 1 -- multiply three 8-bit numbers");
    $display(); 
	$display(" %d*%d*%d",a,b,c);
	p = a*b*c;
	#20ns reset = 0;
    wait(done);
    #20ns	        
// diagnostics: compare a*b*c against what the DUT computes 
    $display();
	$display ("math prod = %d; DUT prod = %d",p,{pa1.dm1.my_memory[4],pa1.dm1.my_memory[5]});

	dat_ram[4] = pa1.dm1.my_memory[4];
	dat_ram[5] = pa1.dm1.my_memory[5];

	if(p=={pa1.dm1.my_memory[4],pa1.dm1.my_memory[5]}) $display("program 1 success");
	else $display("program 1 failure");
//    $displayh("prod=0x%h 0x%h",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
//    $display();
//    $display("cycle_count = %d",pa1.pr1.cycle_ct);
    $display("\n \n");
	
// now start the first "where's Waldo?" pattern search     
	$display("program 2 -- pattern search");
    $display();
    #10ns;
	pa1.dm1.my_memory[6] = 4'b0011;     // Waldo himself :)
    $display("pattern = %b",pa1.dm1.my_memory[6][3:0]);
    $display();
	dat_ram[6]          = pa1.dm1.my_memory[6];
	for(int i=32; i<96; i++) begin  :op_ld_loop
	  pa1.dm1.my_memory[i] = $random;
	  dat_ram[i] = pa1.dm1.my_memory[i];
      if(dat_ram[i][3:0]==dat_ram[6] ||
         dat_ram[i][4:1]==dat_ram[6] ||
         dat_ram[i][5:2]==dat_ram[6] ||
         dat_ram[i][6:3]==dat_ram[6] ||
         dat_ram[i][7:4]==dat_ram[6])
		 begin
           ct++;
//           $display("bench",,,ct,,,i);      
	     end
	end	   : op_ld_loop
    	#10ns reset = 1;
	#20ns reset = 0;
	wait(done);
	#20ns
	$display("math match count = %d; DUT count = %d",ct,pa1.dm1.my_memory[7]);
	if(ct==pa1.dm1.my_memory[7]) $display("program 2 success");
	else $display("program 2 failure");
    $display("\n \n");









    $display("program 3 -- minimum pair distance");
	$display();
// start the third program
    dist1 =   0;
    dist2 = 255;
    ct3   =   0;
//	test   = $random(seed);
//	$display("test = %d",test);
   	for(int i=128;i<148;i++) begin
	 dat_ram[i] = (i-128)*12 - 128;           // feel free to vary seed
	  pa1.dm1.my_memory[i] =  dat_ram[i];
	  $display(i,,dat_ram[i]);
	end
    for(int k=128; k<148; k++)						// nested loops to cover all
	  for(int j=128; j<k; j++) begin				//  pairs
		ct3++;
		if(k!=j) dist1 = dat_ram[k]-dat_ram[j];		// k!=j to avoid diagonal (element distance from self)
// need abs(dist1)
		if(dist1[8]) dist1 = dat_ram[j]-dat_ram[k];
//		$display(dist2,,,dist1,,,k,,,j,,,dat_ram[k],,,dat_ram[j],,,ct);
		if(dist1<dist2) begin
//		  $display("dist1=%d, dist2=%d, %d, %d",dist1,dist2,dat_ram[j],dat_ram[k]);
		  dist2 = dist1;					        // set a new minimum
		end
//           $display("bench",,,ct,,,i);      
	  end
	#10ns reset = 1;
    #20ns reset = 0;
	wait(done);
	#20ns $display("math dist = %d, DUT dist = %d",dist2,pa1.dm1.my_memory[127]);
    if(dist2==pa1.dm1.my_memory[127]) $display("program 3 success");
	else $display("program 3 failure");
	$display("\n \n");
    #10ns;
/*
// start a second round of problems -- we can/should randomize in future runs
	a = 12;
	b = 3;
	c = 4;
	pa1.pr1.data_ram[1] =  a;
	pa1.pr1.data_ram[2] =  b;
	pa1.pr1.data_ram[3] =  c;
	reset = 1;
	$display(" %d*%d*%d",a,b,c);
	p = a * b * c;
	#20ns reset = 0;
    wait(done);
	$display ("prod= %d  %d",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
    $displayh("prod=0x%h 0x%h",p,{pa1.pr1.data_ram[4],pa1.pr1.data_ram[5]});
    $display("cycle_count = %d",pa1.pr1.cycle_ct);	 */
    $stop;	 
  end
// irrespective of what you read in textbooks and online, this is the preferred clock syntax
  always begin
    #5ns clk = 1;
	#5ns clk = 0;
  end

endmodule