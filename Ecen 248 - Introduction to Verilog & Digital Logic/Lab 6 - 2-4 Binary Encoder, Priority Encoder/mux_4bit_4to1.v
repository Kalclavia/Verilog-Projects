`timescale 1ns / 1ps
`default_nettype none
/* This module describes a 4-bit, 4:1 multiplexer 
using behavioral constructs in Verilog HDL*/
module mux_4bit_4to1(Y, A, B, C, D, S);

    //declare output and input ports
    output reg [3:0] Y; //output is a 4-bit wide reg
    input wire [3:0] A, B, C, D;    //4-bit wide input wires
    input wire [1:0] S;             // select is a 2-bit wide wire
    
    
    always@(*) begin  //new Verulog trick - * means triggr when anything changes
        //notice we did not use the begin and end bcause
        // the cas statement is considered in one clause
        case(S) // selection based on S
            2'b00: Y = A;   //when S == 2'b00, connect to mux wire A
            2'b01: Y = B;   //when S == 2'b01, connect to mux wire B
            2'b10: Y = C;   //when S == 2'b10, connect to mux wire C
            2'b11: Y = D;   //when S == s'b11, connect to mux wire D
        endcase     // designates the end of a case statement
    end
endmodule