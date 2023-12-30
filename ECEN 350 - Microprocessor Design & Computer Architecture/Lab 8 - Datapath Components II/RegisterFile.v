`timescale 1ns / 1ps
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);

  output  [63:0] BusA;
  output  [63:0] BusB;

  input [4:0] RA, RB, RW;
  input [63:0] BusW;
  input RegWr, Clk;

 

  reg [63:0] registers [31:0];
  
    // Read data from registers with a 2-tic delay
    assign #2 BusA = RA == 5'b11111 ? 0: registers[RA];
    assign #2 BusB = RB == 5'b11111 ? 0: registers[RB];

  always @(negedge Clk) begin
    if (RegWr) begin
      if(RW == 5'b11111) begin
        registers[RW] <= #3 0;
      end else 
      // Write to the register specified by RW with a 3-tic delay
      registers[RW] <= #3 BusW;
    end
  end


endmodule
