`timescale 1ns / 1ps
`default_nettype none

module up_counter(Count, Carry2, En, Clk, Rst);

    output reg [2:0] Count;
    output wire Carry2;
    
    //inputs are wires
    input wire En, Clk, Rst;
    
    // intermediate nets
    wire [2:0] Carry, Sum;
    
    // Let's create and instantiate a wrapper for the 3-bit counter first
    Threebit_counter UC1(Sum, Carry2, Count, En);
    
    // describe positive edge triggered flipflops for count
    // (implies asyncronous reset)
    
    always@(posedge Clk or posedge Rst)
        if(Rst) // if Rst == 1'b1
            Count <= 0'
        else    // Otherwise, latch the sum
            Count <= Sum;
 endmodule
 
 module Threebit_counter(Sum, Carry2, Count, En);
    
    // first declare vars
    input wire En;
    input wire [2:0] Count;
    output wire [2:0] Sum;
    output wire Carry2;
    wire [2:0] Carry;
    
    // instantiate and write your half-adders down here
    half_adder ha1
   