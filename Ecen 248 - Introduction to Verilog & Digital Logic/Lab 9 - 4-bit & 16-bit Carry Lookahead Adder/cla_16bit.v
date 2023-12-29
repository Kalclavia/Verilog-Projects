`timescale 1 ns/ 1 ps
`default_nettype none

module block_carry_lookahead_unit(G_star, P_star, C, G, P, C0);
    output wire G_star, P_star; //this is defining all of the inputs and outputs
    output wire [3:1] C;
    input wire [3:0] G, P;
    input wire C0;

    //assigning each all of the internal structures of the circuit using the lab manual
    assign #4 C[1] = G[0]|P[0]&C0;
    assign #4 C[2] = G[1]|P[1]&G[0]|P[1]&P[0]&C0;
    assign #4 C[3] = G[2]|P[2]&G[1]|P[2]&P[1]&G[0]|P[2]&P[1]&P[0]&C0;
    assign #4 G_star = G[3]|P[3]&G[2]|P[3]&P[2]&G[1]|P[3]&P[2]&P[1]&G[0];
    assign #2 P_star = P[3]&P[2]&P[1]&P[0];
endmodule

module carry_lookahead_16bit(Cout, S, X, Y, Cin);
    output wire Cout; //this is defining input and output wires
    output wire [15:0] S;
    input wire [15:0] X, Y;
    input wire Cin;
    wire [16:0] C; //this is the internal wires to be used in the units called later on
    wire [15:0] P, G;
    wire [3:0] P_star, G_star;

    assign C[0] = Cin; //this is assigning Cin to be the first bit of the C wire
                        //each of the units called from this point forward are set up based on the schematic from the manual
    
    generate_propagate_unit GPU(G, P, X, Y);
    block_carry_lookahead_unit BCLAU0( //this is calling the block-carry-lookahead and setting up variables
        .G_star (G_star[0]),
        .P_star (P_star[0]),
        .C (C[3:1]),
        .G (G[3:0]),
        .P (P[3:0]),
        .C0 (C[0])
    );

    block_carry_lookahead_unit BCLAU1( //this is calling second block carry lookahead unit
        .G_star (G_star[1]),
        .P_star (P_star[1]),
        .C (C[7:5]),
        .G (G[7:4]),
        .P (P[7:4]),
        .C0 (C[4])
    );
    
    block_carry_lookahead_unit BCLAU2( //this is calling third block carry lookahead unit
        .G_star (G_star[2]),
        .P_star (P_star[2]),
        .C (C[11:9]),
        .G (G[11:8]),
        .P (P[11:8]),
        .C0 (C[8])
    );
    
    block_carry_lookahead_unit BCLAU3( //this is calling the fourth lookahead unit
        .G_star (G_star[3]),
        .P_star (P_star[3]),
        .C (C[15:13]),
        .G (G[15:12]),
        .P (P[15:12]),
        .C0 (C[12])
    );

    carry_lookahead_unit CLAU( //this is the carry lookahead unit
        .C({C[16], C[12], C[8], C[4]}),
        .G(G_star[3:0]),
        .P(P_star[3:0]),
        .C0(C[0])
    );
    
    summation_unit SU( //this is the summation unit
        .S(S[15:0]),
        .P(P[15:0]),
        .C(C[15:0])
    );
    
    assign Cout=C[16]; //this is assigning Cout to be the last bit of the C wire
endmodule