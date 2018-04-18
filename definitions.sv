//This file defines the parameters used in the alu
package definitions;
    
typedef enum logic[4:0] {
  MOV   = 5'b00000,	    // since these start at 0 and are in
  IMOV  = 5'b00001,
  MOVTO = 5'b00010,
  CMP   = 5'b00011,
  ICMP  = 5'b00100,
  LSL   = 5'b00101,
  ILSL  = 5'b00110,
  RSL   = 5'b00111,
  IRSL  = 5'b01000,
  AND   = 5'b01001,
  XOR   = 5'b01010,
  ADD   = 5'b01011,
  IADD  = 5'b01100,
  SUB   = 5'b01101,
  ISUB  = 5'b01110,
  MOD   = 5'b01111,
  LDR   = 5'b10000,
  STR   = 5'b10001,
  B     = 5'b10010,
  BEQ   = 5'b10011,
  LDROV = 5'b10100,
  CLROV = 5'b10101,
  OR    = 5'b10110,
  BLE   = 5'b10111,
  BGE   = 5'b11000,
  RLDR  = 5'b11001,
  ABS   = 5'b11010

	 } op_code;
	 
endpackage // defintions
