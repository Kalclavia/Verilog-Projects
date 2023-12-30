module HalfAdd ( Cout , Sum , A, B ) ;
  input A, B ;
  output Cout , Sum ;
  wire t,at,bt; //This was dumb and needed extra wires
  nand nand1(t, A,B); //if they are both true only then will t be 0
  nand nand2(Cout,1,t); //cout will only b true if t is 0
  nand nand3(at,A,t); //determined that both a and b arent true now cheking if either is true
  nand nand4(bt,B, t);
  nand nand5 (Sum, at, bt); //if only one but not both are true then sum is true
endmodule
