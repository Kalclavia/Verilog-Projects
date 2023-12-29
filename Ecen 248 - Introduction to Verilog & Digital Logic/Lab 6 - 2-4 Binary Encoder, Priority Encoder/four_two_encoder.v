`timescale 1ns/1ps
`default_nettype none

/* module interface for the 4:2 encoder */
module four_two_encoder (
  input wire [3:0] W, 
  output reg [1:0] Y, // Y should be a 2-bit output of type reg
  output wire zero
);

/* can mix levels of abstraction! */
assign zero = (W == 4'b0000); // a zero test! notice the use of == rather than =

/* behavioral portion */
always @(*) 
begin // not necessary because case is single clause but looks better
  case (W) // selection based on W
    4'b0001: Y = 2'b00; // 2'b signifies a 2-bit binary value
    4'b0010: Y = 2'b01; // w[1] is lit up
    4'b0100: Y = 2'b10;         // fill in the case where only w[2] is lit up
    4'b1000: Y = 2'b11; // w[3] is lit up
    default: Y = 2'bXX; // default covers cases not listed!
  endcase // designates the end of a case statement
end

endmodule
