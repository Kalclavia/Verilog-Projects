`timescale 1ns / 1ps
`default_nettype none
/*This module describes a 1-bit wide multiplexer using structural constructs
and gate-level primitives built into Verilog*/
 
module two_one_mux (Y, A, B, S);

    // declare output and input ports
    output wire Y;
    input wire A, B, S;
    
    // declare internal nets
    wire notS; // inverse of S
    wire andA; // output of and0 gate
    wire andB; // output of and1 gate
    
    // instantiate gate-level modules
    not not0(notS, S);
    and and0(andA, notS, A);
    and and1(andB, S, B);
    or or0(Y, andA, andB);
     
endmodule // designate end of module 
