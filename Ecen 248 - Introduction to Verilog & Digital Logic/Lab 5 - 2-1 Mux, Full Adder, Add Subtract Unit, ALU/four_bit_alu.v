`timescale 1ns / 1ps
`default_nettype none

module four_bit_alu(
    output wire [3:0] Result, 
    output wire Overflow,
    input wire [3:0] opA, opB,
    input wire [1:0] ctrl);
    
    wire[3:0] AddSub_to_Mux, And_to_Mux;
    wire Out_to_Overflow;
    
    // use dataflow to describe gate-level activity
    assign And_to_Mux[0] = opA[0] & opB[0];
    assign And_to_Mux[1] = opA[1] & opB[1];
    assign And_to_Mux[2] = opA[2] & opB[2];
    assign And_to_Mux[3] = opA[3] & opB[3];
        
    
    add_sub adder_sub0(AddSub_to_Mux, Out_to_Overflow, opA, opB, ctrl[1]);
    four_bit_mux mux_unit0(Result, AddSub_to_Mux, And_to_Mux, ctrl[0]);
    assign Overflow = Out_to_Overflow & ctrl[0];
    
 endmodule
    
