`timescale 1ns/ 1ps //the delay unit is 1ns
`default_nettype none

module d_latch_behavioral(

output reg Q, //driven with behavioural statements
output wire notQ,//driven with dataflow statemtn
input wire D, En //wires can drive regs

);

/*describe behaviour of D-latch*/
always@(En or D)

if(En) //we will look at what this says: if En!= 1'b0
Q=D;
//else Q=Q;//this is implied so uneccessary

assign notQ = ~Q; //regs can drive wires

endmodule