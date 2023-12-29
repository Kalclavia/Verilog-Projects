`timescale 1ns / 1ps
`default_nettype none

module clock_divider(ClkOut, ClkIn);

    output wire [3:0] ClkOut;
    input wire ClkIn;   // wires can drive regs
    
    parameter n = 5;
    
    reg [n:0] Count;
    
    always@(posedge ClkIn)  //this should look familiar...
        Count <= Count + 1;
    
    // now we wire up ClkOut (4-bit wire) to most significant bits
    assign ClkOut[3:0] = Count[n:n-3];
    
endmodule