// Create Date:    17:44:49 2012.16.02 
// Latest rev:     2017.10.26
// Design Name:    CSE141L
// Module Name:    IF 

// generic program counter
module IF(
  input [7:0] abs,
  input abs_jmp,
  input reset,
  input Halt,
  input clk,
  input logic[1:0] state,
  output logic[7:0] PC             // pointer to insr. mem
  );
	 
  
  always @(posedge clk)
	if(reset) begin                       
	  if(state == 0) PC <= 0; // reset to 0 and hold there
	  else if (state == 1) PC <= 67; 
	  else if (state == 2) PC <= 121; 
	end 
	else if(Halt)					// freeze
	  PC <= PC;						
	else if(abs_jmp)				// jump by specified amount
	  PC <= abs;
	else							// normal advance thru program
	  PC <= PC+1;

endmodule
