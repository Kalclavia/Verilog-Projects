`timescale 1ns/1ps
`default_nettype none

//module describing a priority encoder
module priority_encoder (
  input wire [3:0] W,
  output reg [1:0] Y,
  output wire zero //define inputs and outputs, especially for zero
);

assign zero = (W == 4'b0000); // a zero test! notice the use of == rather than =

always @(*) // trigger when W changes
begin
  casex (W)
    4'b0001: Y = 2'b00; // 2'b signifies a 2-bit binary value
    4'b001X: Y = 2'b01; // w[1] is lit up
    4'b01XX: Y = 2'b10;       // fill in the case where only w[2] is lit up
    4'b1XXX: Y = 2'b11; // w[3] is lit up
    default: Y = 2'bXX; // default covers cases not listed!
  endcase
end

endmodule
