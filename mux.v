`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  This module implements a multiplexer (mux) that selects one of two inputs based on a select signal
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux
#(
    // Parameter N specifies the width of the data signals
    parameter N = 32
)
(
    // Input data signals
    input wire [N-1: 0]  data_true, data_false,
    // Select signal
    input wire           sel,
    // Output data signal
    output wire [N-1: 0] data_out
);

    // The assign statement implements the mux functionality
    assign data_out = (sel) ? data_true : data_false;

endmodule
