
`timescale 1ns/ 1ps //the delay unit is 1ns
`default_nettype none

/*here we will create the very first synchronous adder*/

module adder_synchronous(Carry_reg, Sum_reg, Clk, A, B);

/*output ports are regs*/

output reg Carry_reg;
output reg [1:0] Sum_reg;

/*inputs are still wires*/

input wire Clk;
input wire [1:0] A,B;

/*here are our intermediate nets*/

reg[1:0] A_reg, B_reg; //we will use these two-bit registers


wire Carry; //this needs to connect to registers described below 

wire [1:0] Sum;

/*here we instantiate our 2bit adder*/

/*this behavioural block describes 2 bit registers*/

adder_2bit adder0(Carry,Sum,A,B);

always@(posedge Clk) //this triggers on the positive edge of the clock

begin

A_reg<=A;//nonblocking assignments are used because we want the two statements to happen concurrently 

B_reg<=B;

end

/*here is described the registers for the result*/
always@(posedge Clk)
begin

Carry_reg<=Carry; //this is to basically drive the registers
Sum_reg<=Sum;

end

endmodule//yeet!