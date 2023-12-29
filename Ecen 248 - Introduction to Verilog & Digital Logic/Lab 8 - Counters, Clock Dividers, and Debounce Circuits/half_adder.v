`timescale 1ns / 1ps
`default_nettype none
/* This module describes the gate-level model of
a full-adder in Verilog*/

module half_adder (S, Cout, A, B, Cin);

    // declare intput and output ports
    //1-bit wires
    input wire A, B, Cin; //1-bit wires
    output wire S, Cout;
   
    // use dataflow to describe gate-level activity
    assign S = A ^ B; // the hat (^) is for XOR
    
    // this line is missing something
    assign Cout = A & B;  // pipe (|) is for OR operation
    
 endmodule