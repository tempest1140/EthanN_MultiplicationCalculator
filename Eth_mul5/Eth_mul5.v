//error: logic is faulty: check LED assignment first

//upgrade from Eth_mul3: instead of brute-forcing it, I looked at the truth table and saw the patterns
//warning: due to negative logic, the documentation may sometimes read the negative version of the correct value
//this program has been tested using a negative logic board: icestick eval board

// Ethan T. Nichols
// 08/05/23
// Lattice icestick fpga eval board
// Multiply two 2-bit numbers and diplay using number of LED's
// Attribution License
// Credit:	Ms. Chee Yum taught me Verilog
//		Andrew McClary II helped me learn Verilog

`timescale 1ns/10ps //time units and precision

//design module

module Eth_mul(X,Y,Z,N,A,B,C,D);
output X,Y,Z,N;
input A,B,C,D;

//interconnections
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12;

//gates

//all buttons are negative logic
not g13(w9,A); //w9 = A'
not g14(w10,B);//w10 = B'
not g15(w11,C); //w11 = C'
not g16(w12,D); //w12 = D'

//X-bit's logic
and g1(X,w9,w10,w11,w12); //X = A' & B' & C' & D'

//Y's logic
and g2(w1,w9,w11);// w1 = A' & C'
nand g3(w2,w9,w10,w11,w12); //w2 = (A' & B' & C' & D')'
and g4(Y,w1,w2);// Y = w1 & w2

//Z-bit's logic
xor g9(w7,w11,w12); // w7 = C' ^ D'

and g6(w4,A,w10,w11); // w4 = A & B' & C'
and g8(w6,B,w9,w12); // w6 = A' & B & D'
and g10(w8,w9,w10,w7); // w8 = A' & B' & w7

or g11(Z,w4,w6,w8); // Z = w4 & w6 & w8

//N-bit's logic
and g12(N,w10,w12); // N = B' & D'

endmodule //end of design module