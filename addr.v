`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 11:53:54 AM
// Design Name: 
// Module Name: addr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addr
#(  parameter N = 32  // N is the number of bits in the adder
)(
    input [N-1:0] X, Y,  // the two input vectors
    output [N-1:0] Z    // the sum output vector
    );
    
    assign Z = X + Y;
endmodule

