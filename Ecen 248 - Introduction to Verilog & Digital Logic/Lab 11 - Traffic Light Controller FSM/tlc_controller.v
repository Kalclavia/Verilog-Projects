`default_nettype none

// THis module describes the top level traffic light controller module discussed in lab 11

module tlc_controller(
    output wire [1:0] highwaySignal, farmSignal, //connected to LEDs
    output wire [3:0] JB,
    input wire Clk,
    
    // the buttons provide input to our top-level circuit
    input wire Rst,  //use as reset
    input wire farmSensor
);

    // intermediate nets
    wire RstSync;
    wire RstCount;
    wire farmSync;
    reg [30:0] Count;
    
    assign JB[3] = RstCount;
    
    // syncronize button inputs
    synchronizer syncRst(RstSync, Rst, Clk);
    synchronizer syncFS(farmSync, farmSensor, Clk);
    
    // instantiate FSM
    
   tlc_fsm FSM(
        .state(JB[2:0]), //wire state up to J for debug
        .RstCount(RstCount),
        .highwaySignal(highwaySignal[1:0]),
        .farmSignal(farmSignal[1:0]),
        .Count(Count[30:0]),
        .Clk(Clk),
        .Rst(RstSync),
        .farmSensor(farmSensor),
        .farmSync(farmSync)
   );
   
   // counter w/ sybcronous reset
   always@(posedge Clk)
        if(RstCount)
            Count <= 0;
        else
            Count <= Count + 1;

endmodule 
   

   
   
      