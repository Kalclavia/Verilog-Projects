module SignExtender(BusImm, Imm26, Ctrl); 
   output [63:0] BusImm; 
   input [25:0]  Imm26; 
   input [1:0] Ctrl; 

   assign BusImm = 
      (Ctrl == 2'b00) ? {{38{Imm26[25]}}, Imm26[25: 0]}:
      (Ctrl == 2'b01) ? {{38{Imm26[25]}}, Imm26[25: 0]}:
      (Ctrl == 2'b10) ? {{36{Imm26[25]}}, Imm26[25: 0], 2'b0}:
      (Ctrl == 2'b11) ? {{36{Imm26[25]}}, Imm26[25: 0], 2'b0}:
      0;   
endmodule
