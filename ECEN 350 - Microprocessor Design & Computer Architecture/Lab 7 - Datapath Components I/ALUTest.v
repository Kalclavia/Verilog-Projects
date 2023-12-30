`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;
	
	
	initial //This initial block used to dump all wire/reg values to dump file
     begin  
       $dumpfile("ALUTest.vcd"); //renamed to match code and module
       $dumpvars(0,ALUTest_v);
     end
     
	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h2}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "ADD 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h69, 64'h420, 4'h2}; #40; passTest({Zero, BusW}, 65'h489, "ADD 0x69,0x420", passed);
		{BusA, BusB, ALUCtrl} = {64'hBABE, 64'hBEEF, 4'h2}; #40; passTest({Zero, BusW}, 65'h179AD, "ADD 0x1234,0xABCD0000", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h420, 4'h0}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "AND 0x0,0x420", passed);
		{BusA, BusB, ALUCtrl} = {64'h4522, 64'hFFFF, 4'h0}; #40; passTest({Zero, BusW}, 65'h4522, "AND 0x4522,0xFFFF", passed);
		{BusA, BusB, ALUCtrl} = {64'h7382, 64'h1F1F, 4'h0}; #40; passTest({Zero, BusW}, 65'h1302, "AND 0x7382,0x1F1F", passed);
		
		{BusA, BusB, ALUCtrl} = {64'hBABE, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, 65'hBABE, "OR 0xBABE,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hBEE1, 64'h1234, 4'h1}; #40; passTest({Zero, BusW}, 65'hBEF5, "OR 0xBEE1,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'h1248, 64'h8421, 4'h1}; #40; passTest({Zero, BusW}, 65'h9669, "OR 0x1248,0x8421", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h4321, 64'h1111, 4'h6}; #40; passTest({Zero, BusW}, 65'h3210, "SUB 0x4321,0x1111", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFF, 64'hFFFF, 4'h6}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "SUB 0xFFFF,0xFFFF", passed);
		{BusA, BusB, ALUCtrl} = {64'h8008, 64'h0, 4'h6}; #40; passTest({Zero, BusW}, 65'h8008, "SUB 0x8008,0x0", passed);
		
		{BusA, BusB, ALUCtrl} = {64'hFFFF, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, 65'h10000000000000000, "PassB 0xFFFF,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'h8679305, 64'h822993167, 4'h7}; #40; passTest({Zero, BusW}, 65'h822993167, "PassB 0x8679305,0x822993167", passed);
		{BusA, BusB, ALUCtrl} = {64'h2468, 64'hAAAA, 4'h7}; #40; passTest({Zero, BusW}, 65'hAAAA, "PassB 0x2468,0xAAAA", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	


		allPassed(passed, 15);
	end
      
endmodule

