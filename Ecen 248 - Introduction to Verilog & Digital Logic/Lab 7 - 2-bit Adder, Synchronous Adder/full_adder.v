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
    assign #6 S = A ^ B ^ Cin; // the hat (^) is for XOR
    assign #6 andAB = A & B;
    // filled in code for andBC, andAC
    assign #6 andBCin = B & Cin;
    assign #6 andACin = A & Cin;
    
    // this line is missing something
    assign #6 Cout = andAB | andBCin | andACin;  // pipe (|) is for OR operation
    
 endmodule