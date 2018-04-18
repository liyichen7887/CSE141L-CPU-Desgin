// Create Date:    2017.05.05
// Latest rev:     2017.10.26s
// Created by:     J Eldon
// Design Name:    CSE141L
// Module Name:    Reg File

// register file with asynchronous read and synchronous write
// parameter raw = "RF address width" -- default is 4 bits,
//   for 16 words in the RF
// generic version has two separate read addresses and an
//  independent write address
// these may be strapped together or decoded in any way,
//  to save instruction or decoder bits
// reads are always enabled, hence no read enable control
import definitions::*;

module reg_file #(parameter raw = 4)
    (input             clk		     ,    // clock (for writes only)
    input   [raw-1:0]  rs_addr_i	 ,	  // read pointer rs
    input   [raw-1:0]  rt_addr_i	 ,	  // read pointer rt
    input   [raw-1:0]  write_addr_i,	  // write pointer (rd)
    input              acc_wen,	  // acc write enable
    input              reg_wen,	  // reg write enable
    input              reg_read, // need to read from reg file signal
    input        [7:0] write_data_i,	  // data to be written/loaded 
    output logic [7:0] rs_val_o	,	  // data read out of reg file
    output logic [7:0] rt_val_o, 
    output logic [7:0] RF [2**raw]);

			  // core itself
// two simultaneous, continuous, combinational reads supported
assign rs_val_o = RF [0];

always_comb
begin
	if(reg_read)
		assign rt_val_o = RF [rt_addr_i]; 
	else
		assign rt_val_o = rt_addr_i;	
end

// synchronous (clocked) write to selected RF content "bin"
always_ff @ (posedge clk)
begin
  if (acc_wen) 
	RF [0] <= write_data_i;
  else if (reg_wen)
	RF [write_addr_i] <= write_data_i;

end
endmodule

