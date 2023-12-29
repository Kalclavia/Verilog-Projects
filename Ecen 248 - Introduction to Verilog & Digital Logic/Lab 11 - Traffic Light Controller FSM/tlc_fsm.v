`timescale 1ns/1ps
`default_nettype none

`define one_sec 50000000
`define three_sec 150000000
`define fifteen_sec 750000000
`define thirty_sec 1500000000

module tlc_fsm(state, RstCount, highwaySignal,farmSignal, Count, Clk, Rst, farmSensor, farmSync);
    output reg[2:0] state;      // output for debugging
    output reg RstCount;        // use an always block
    // another always block for these as well
    output reg[1:0] highwaySignal, farmSignal;
    input wire [30:0] Count;     // use n computed earlier
    input wire Clk, Rst, farmSensor, farmSync;         // clock and reset

parameter S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        S5 = 3'b101,
        S6 = 3'b110,
        green = 2'b11,
        yellow = 2'b10,
        red = 2'b01;
        
 reg[2:0] nextState;
 
 always@(*)
    case(state)
        S0: begin
            highwaySignal = red;
            farmSignal = red;
            if (Count >= `one_sec)
                begin
                RstCount = 1;
                nextState = S1;
                end
            else if (farmSensor == 1)
                begin
                RstCount = 1;
                nextState = S4;
                end
            else
                begin
                RstCount = 0;
                nextState = S0;
                end
            end
        S1: begin
            highwaySignal = green;
            farmSignal = red;
            if (farmSensor == 1 && Count >= `thirty_sec)
                begin
                RstCount = 1;
                nextState = S2;
                end
            else
                begin
                RstCount = 0;
                nextState = S1;
                end
            end
        S2: begin
            highwaySignal = yellow;
            farmSignal = red;
            
            if (Count>= `three_sec)
                begin
                RstCount = 1;
                nextState = S3;
                end
            else
                begin
                RstCount = 0;
                nextState = S2;
                end
            end
        S3: begin
            highwaySignal = red;
            farmSignal = red;
            if(Count >= `one_sec)
                begin
                RstCount = 1;
                nextState = S4;
                end
            else
                begin
                RstCount = 0;
                nextState = S3;
                end
            end
        S4: begin
            highwaySignal = red;
            farmSignal = green;
            if (Count >= (`fifteen_sec + `three_sec) || (farmSensor == 0 && Count >= `three_sec))
                begin
                RstCount = 1;
                nextState = S5;
                end
            else
                begin
                RstCount = 0;
                nextState = S4;
                end
            end
        S5: begin
            highwaySignal = red;
            farmSignal = yellow;
            if(Count >= `three_sec && farmSensor == 1)
                begin
                RstCount = 1;
                nextState = S6;
                end
            else if(Count >= `three_sec)
                begin
                RstCount = 1;
                nextState = S0;
                end
            else
                begin
                RstCount = 0;
                nextState = S5;
                end
            end
         S6: begin
            highwaySignal = red;
            farmSignal = red;
            if (Count >= `one_sec)
                begin
                RstCount = 1;
                nextState = S1;
                end
            else
                begin
                RstCount = 0;
                nextState = S6;
                end
            end
        endcase

// update loop
always@(posedge Clk)
    if(Rst)
        state <= S0;
    else
        state <= nextState;
        
 endmodule