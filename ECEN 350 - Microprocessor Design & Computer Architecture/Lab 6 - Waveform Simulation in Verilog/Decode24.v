module Decode24 ( out , in ) ;
  input [ 1 : 0 ] in ;
  output [ 3 : 0 ] out ; //Decode takes in a binary number and switches to that number path
  wire nt1,nt2;
  
  not not1(nt1, in[0]);  // zero check
  not not2(nt2, in[1]);
   
  and and1(out[0], nt1,nt2); // checks if both inputs are zero for path 0
  and and2(out[1], in[0],nt2); //checks if input is 0 1 for path 1
  and and3(out[2], nt1,in[1]); //checks if input is 1 0 for path 2
  and and4(out[3], in[0],in[1]); // checks if input is 11 for path 3
  
  endmodule
