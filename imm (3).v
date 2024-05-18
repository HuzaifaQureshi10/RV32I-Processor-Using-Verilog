module imm(
    input wire[31:0] ins,
    input wire[2:0] cont,
    output reg [31:0] imm
);

always@(*) begin
    case(cont)
    3'b000: imm = {{20{ins[31]}}, ins[31:20]}; //I
    3'b001: imm = {{20{ins[31]}}, ins[31:25], ins[11:7]};   //S
    3'b010: imm = {{20{ins[31]}}, ins[30:25], ins[7], ins[11:8], 1'b0}; //B
    3'b011: imm = {{11{ins[31]}}, ins[31], ins[19:12], ins[20], ins[30:21], 1'b0};     //J
    3'b100: imm = {ins[31:12], 12'd0};  //U
    3'b101: imm = {27'd0, ins[24:20]}; ////I sll


    endcase
end

endmodule
/* 
since in this architecture we are working with 32 bit registers , we need to sort out imm
which has a different length depending on the type of instruction. So we need to extend 
imm to 32 bits appropriately. 
Case 0 : I type instructions have a 12 bit imm which is the upper 12 bits of the ins. 
         Since in I type the imm is a 2s comp , we can extend the sign bit 20 times 
			and use the lower 12 bits for the remaining 12 bits to complete 32 bits. 
			
Case 1: For S type instructions imm is the offset used for the base address (rs1) of 
		  the data memory. Again, its a 12 bit value and 2s comp. So we extend sign bit
		  just like case 0. The only diff is that this time the 12 bits of imm are not 
		  the first 12 bits of the ins rather its broken up. (see reference card) 
		  
Case 2: 

Case 3: In J type instruction, imm is the offset between the current instruction 
		  address and the address where we want to jump. So this 20 bit imm since its 
		  2s comp , is sign extended 
