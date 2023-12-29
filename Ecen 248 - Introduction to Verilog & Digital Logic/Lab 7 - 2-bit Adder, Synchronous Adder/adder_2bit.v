module adder_2bit(Carry, Sum, A, B);

//carry is a 1 bit output
output wire [1:0]Sum,Carry;
input wire [1:0]A,B;

wire C0;
//wire c1;

//Sum is a 2-bit output

//A, B are are 2 bit inputs

//we then need the adder_2bit tb and do the proper implementation

full_adder fulleradder0(Sum[0],C0,A[0],B[0],1'b0);

full_adder fulladder1(Sum[1],Carry,A[1],B[1],C0);

endmodule