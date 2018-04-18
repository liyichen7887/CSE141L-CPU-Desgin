CSE 141L Final CPU Desgin: 9-Bit Instruction Set Architecture
=======================================================

Author: Yichen Li, Yeyao Tao, Bohan Yao


Introduction:
=======================================================

The instruction set architecture is named 3Y. It is designed specifically to solve the 3 problems introduced in this lab assignment, which are product of three unsigned numbers, string match and closest pair. The detailed descriptions of those 3 problems will be included afterwards.This architecture is designed to support a special-purpose reduced instruction set(RISC) processor and it tries to accomplish the tasks in a very limited 9-bit instruction size. Thus, the amount of operations is very limited. The architecture follows the classical model of accumulator to keep a balance between the number of registers and the number of operations it supports. It also follows conventions used by ARM architecture to make the design more feasible before we move on to hardware design.


Instruction formats:
=======================================================

Since we adopt the accumulator model in our ISA design, we chose our instruction format to be 5-bit opcode and 4-bit operand so that the architecture can support up to 32 types of instructions and 16 registers.


Internal operands:
=======================================================

5 bits for opcode and 4 bits for operand, so 16 registers are supported. One would be a 1-bit overflow condition register.


Control flow:
=======================================================

The architecture support two kinds of branches, operation b​ for direct jump and operation beq for conditional jump under equal condition. We will predefine a lookup table beforehand to map the 4 bit operand to the number of lines it needs to jump in a 16*8 two dimensional array. When branch operation is called, the architecture references the lookup table and add the signed number fetched to the current program counter to reach the line the assembly program needs to go to.


Addressing modes:
=======================================================

This instruction will reference the 8-bit address element at index 1 at the lookup table and the value stored in that memory address will be loaded into the accumulator.