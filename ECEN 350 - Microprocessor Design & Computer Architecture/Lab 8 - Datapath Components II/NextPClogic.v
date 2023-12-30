module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input  Branch, ALUZero, Uncondbranch; 
   output [63:0] NextPC; 
   
   wire [63:0] lsl2;

   wire doesBranch;
   wire conditional;
   
   assign conditional = Branch && ALUZero;
   assign doesBranch = conditional || Uncondbranch;
   assign lsl2 = SignExtImm64 << 2;
   
   assign NextPC = 
      (doesBranch == 1'b0) ? {CurrentPC + 3'b100}:
      (doesBranch == 1'b1) ? {CurrentPC + lsl2}:
      0;


endmodule
