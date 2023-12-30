

`define STRLEN 32
module SignExtenderTest;

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
   reg [25:0] Imm26;
   reg [1:0] Ctrl;
   reg [7:0] passed;

   // Outputs
   wire [63:0] BusImm;
   
   initial //This initial block used to dump all wire/reg values to dump file
     begin  
       $dumpfile("SignExtenderTest.vcd"); //renamed to match code and module
       $dumpvars(0,SignExtenderTest);
     end

   // Instantiate the module under test
   SignExtender uut(
      .BusImm(BusImm),
      .Imm26(Imm26),
      .Ctrl(Ctrl)
   );


   initial begin
      // Initialize Inputs
		Imm26 = 0;
		Ctrl [1:0] = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{Imm26, Ctrl} = {26'h1234, 2'h0}; #40; passTest({BusImm}, 64'h1234, "I type 1234", passed);
		
		{Imm26, Ctrl} = {26'h1234, 2'h1}; #40; passTest({BusImm}, 64'h1234, "D type 1234", passed);
		{Imm26, Ctrl} = {26'h2001234, 2'h1}; #40; passTest({BusImm}, 64'hFFFFFFFFFe001234, "D type 2001234", passed);
		
		{Imm26, Ctrl} = {26'h1234, 2'h2}; #40; passTest({BusImm}, 64'h48D0, "B/CBZ type 1234", passed);
		{Imm26, Ctrl} = {26'h2001234, 2'h2}; #40; passTest({BusImm}, 64'hFFFFFFFFF80048D0, "B/CBZ type 1234", passed);
		
		{Imm26, Ctrl} = {26'h1234, 2'h3}; #40; passTest({BusImm}, 64'h48D0, "B/CBZ type 1234", passed);
		{Imm26, Ctrl} = {26'h2001234, 2'h3}; #40; passTest({BusImm}, 64'hFFFFFFFFF80048D0, "B/CBZ type 1234", passed);
		

		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	


		allPassed(passed, 5);
   end

endmodule
