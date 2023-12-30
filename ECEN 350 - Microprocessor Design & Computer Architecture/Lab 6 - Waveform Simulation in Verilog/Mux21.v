module Mux21 ( out , in , sel ) ;
  input [ 1 : 0 ] in ;
  input sel ;
  output out ;
  wire si1,si0,ntsel;
  not not1(ntsel,sel); //made a wire since not() in an and fuction gave me an error
  and and1(si0,ntsel,in[0]); // if select is zero use in[0]
  and and2(si1, sel, in[1]); // if select is 1  use 
  or or1(out,si0,si1); //the not used path will always be zero so check if the used path is 1
endmodule
