`timescale 1 ns / 1 ns

module clock_divider_tb;

  reg clock_in;
  wire [3:0] clock_out;

 clock_divider uut (
  .ClkIn(clock_in), 
  .ClkOut(clock_out)
 );

 initial begin
  // Initialize Inputs
  clock_in = 0;
  // input clock 100MHz
        forever #5 clock_in = ~clock_in;
 end
        
  
endmodule