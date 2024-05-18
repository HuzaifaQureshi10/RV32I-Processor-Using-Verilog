module regFile(
    input clk,
    input enrd, //write enable
    input reset,
    input wire [4:0] rdsel,
    input wire [31:0] rd,
    input wire [4:0] rs1sel,
    input wire [4:0] rs2sel,
    output reg[31:0] rs1,
    output reg[31:0] rs2,
    output reg[31:0] out
);

integer i;

reg [31:0] registers[0:31];



always @(posedge clk) begin
    if(enrd) registers[rdsel] <= rd;
end

always @(*) begin
    registers[0] = 0;
    rs1 = registers[rs1sel];
    rs2 = registers[rs2sel];
    out = registers[31];
    if(reset) begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 0;
        end
    end
end

endmodule

/* At every positive edge of clock if write is enabled (enrd) , then we assign the 
rd value to the address rdsel.
The first register of regfile is hardcoded to zero.
The last register of regfile is continously assigned to out.
Also , whenever the addresses for rs1 (rs1sel) and rs2(rs2sel) are changed ,
the module outputs rs1 and rs2 accordingly. In the same block if reset is triggered 
the whole regfile is assigned zero using a loop*/ 
