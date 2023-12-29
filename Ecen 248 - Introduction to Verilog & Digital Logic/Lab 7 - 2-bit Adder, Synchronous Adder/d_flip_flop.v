`timescale 1ns/ 1ps //the delay unit is 1ns
`default_nettype none

module d_flip_flop(Q, notQ, Clk, D);

//declare all ports

output wire Q, notQ; //outputs of slave latch

input wire Clk, D;

/*intermediate nets*/

wire notClk, NotClk, notNotClk;

wire Qm;//output of master latch

//notQm is used in instantiation
//but left unconnected
wire notQm;

//instatiate the NOT gates, adds 2ns delay

not not0(notClk,Clk);
not not1(notNotClk,notClk);

d_latch master_en(Qm,notQm,notClk,D);

d_latch servant_en(Q,notQ,notNotClk,Qm);


// instatiate d latches

endmodule