`timescale 1ns / 1ps
`default_nettype none
/* This module describes the gate-level model of
a full-adder in Verilog*/

module full_adder (S, Cout, A, B, Cin);

    // declare intput and output ports
    //1-bit wires
    input wire A, B, Cin; //1-bit wires
    output wire S, Cout;
    
    // declare internal nets
    wire andBCin, andACin, andAB; // 1-bit wires (missing something???)
    
    // use dataflow to describe gate-level activity
    assign S = A ^ B ^ Cin; // the hat (^) is for XOR
    assign andAB = A & B;
    // filled in code for andBC, andAC
    assign andBCin = B & Cin;
    assign andACin = A & Cin;
    
    // this line is missing something
    assign Cout = andAB | andBCin | andACin;  // pipe (|) is for OR operation
    
 endmodule