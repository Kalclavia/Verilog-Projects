
`define STRLEN 32
module NextPClogicTest;

	task passTest;
		input [63:0] actualOut, expectedOut;
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
   reg [7:0] passed;
   
   reg [63:0] CurrentPC, SignExtImm64; 
   reg  Branch, Uncondbranch; 
   reg ALUZero;

   // Outputs
   wire [63:0] NextPC;
   
   initial //This initial block used to dump all wire/reg values to dump file
     begin  
       $dumpfile("NextPClogicTest.vcd"); //renamed to match code and module
       $dumpvars(0,NextPClogicTest);
     end

   // Instantiate the module under test
   NextPClogic uut(
      .CurrentPC(CurrentPC),
      .SignExtImm64(SignExtImm64),
      .Branch(Branch),
      .ALUZero(ALUZero),
      .Uncondbranch(Uncondbranch),
      .NextPC(NextPC)
   );


   initial begin
      // Initialize Inputs
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h4,64'h0,1'b0,1'b0,1'b0}; #40; passTest({NextPC}, 64'h8, "Not branch", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h4,64'h2,1'b1,1'b1,1'b0}; #40; passTest({NextPC}, 64'hC, "branch zero high", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h4,64'h1,1'b1,1'b0,1'b0}; #40; passTest({NextPC}, 64'h8, "branch zero low", passed);
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h4,64'h2,1'b0,1'b0,1'b1}; #40; passTest({NextPC}, 64'hC, "uncon", passed);
		
		

		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	


		allPassed(passed, 4);
   end

endmodule
