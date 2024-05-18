module rdmux(
    input wire[1:0] sel,
    input wire[31:0] dataMem,
    input wire[31:0] alu,
    input wire[31:0] pc,
    input wire[31:0] imm,
    output reg[31:0] rd 
);

always @(*) begin
    case(sel)
    2'b00: rd = alu;        //R,IA  //  For R type or imm type ALU operation 
    2'b01: rd = dataMem;    //IL    // For Loading from datamemory 
    2'b10: rd = pc + 4;     // For loading address of next instruction to return from a subroutine maybe
    2'b11: rd = imm;    	// Load upper immediate 
    endcase

end


endmodule

//Just decides where to load from depending on type of instruction 