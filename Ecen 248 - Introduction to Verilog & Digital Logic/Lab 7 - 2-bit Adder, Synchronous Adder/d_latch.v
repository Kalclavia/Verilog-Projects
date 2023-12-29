`timescale 1ns/ 1ps //the delay unit is 1ns
`default_nettype none

module d_latch(Q, notQ, En, D);

output wire Q, notQ;
input wire En, D;

//wire nandSEn, nandREn;

wire nandDEn, nandnotDEn,notD;

not #2 notd(notD,D);

nand #2 nand0(nandDEn, D, En);

nand #2 nand1(nandnotDEn,notD, En);

nand #2 nand2(Q,nandDEn,notQ);

nand #2 nand3(notQ,nandnotDEn,Q);


//the rest will be filled in

endmodule