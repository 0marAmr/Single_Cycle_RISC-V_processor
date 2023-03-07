`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 07:29:27 AM
// Design Name: 
// Module Name: instr_mem
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


// Define the instruction memory module with three parameters:
// - ADDRESS_WIDTH: the number of bits in the memory address
// - INSTR_WIDTH: the number of bits in each instruction
// - PROGRAM: the name of the file containing the program instructions
module instr_mem
    #(
        parameter ADDRESS_WIDTH = 32,
        parameter INSTR_WIDTH = 32,
        parameter PROGRAM = "factorial.txt"
    )
    (
        input wire [ADDRESS_WIDTH-1:0] addr, // Input address wire
        output wire [INSTR_WIDTH-1:0] instr // Output instruction wire
    );

    localparam DEPTH = 64; // Set the depth of the instruction memory

    // Declare a register array to hold the instruction memory contents
    // The array is indexed by the address wire and holds instructions of width INSTR_WIDTH
    reg [INSTR_WIDTH-1:0] memory [DEPTH-1:0];

    // Initialize the instruction memory contents from the file specified by PROGRAM
    initial begin
        $readmemh(PROGRAM, memory);
    end

    // Assign the output instruction wire to the instruction memory contents at the input address
    assign instr = memory[addr[31:2]]; // word aligned

endmodule