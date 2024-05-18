module pc(
    input clk,
    input reset,
    input enl, // Load enable
    input wire[31:0] load,      //alu
    output reg[31:0] count
);

always @(posedge clk ) begin
    if(reset) count <= 0;
    else if(enl) count <= load;
    else count <= count + 4;
end
endmodule
/* At every positive edge of clock if reset is high then counter is resetted to zero
otherwise it checks if load enable (enl) is high , if so it loads the 32 bit input "load" 
to counter output "count". This is mostly used in branch or jump instructions. 
Lastly , once reset and load has been checked , it just increments the counter by 4
because the program memory is byte addressible*/ 