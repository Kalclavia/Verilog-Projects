`timescale 1ns/ 1ps //the delay unit is 1ns
`default_nettype none

module d_flip_flop_behavioral(

output reg Q,
output wire notQ,
input wire D,
input wire Clk //this is the clock signal
);
/*describe behaviour of D flip-flop*/

//posedge means positive or rising edge

always@(posedge Clk) //trigger when clk goes high
Q<=D;//non blocking assignement
assign notQ=~Q;
endmodule
