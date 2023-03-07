`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: top_module
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


module top_module(
        input wire clk, n_reset                 // clock and reset inputs
    );

    localparam  ADDRESS_WIDTH = 32,
                INSTR_WIDTH = 32,
                PROGRAM = "factorial.txt";

    wire [31:0] read_data, write_data, alu_result, instr, pc;
    mips mcu (
        // input ports
        .clk(clk),
        .n_reset(n_reset),
        .read_data(read_data),
        .instr(instr),
        // output ports
        .mem_write(mem_write),
        .write_data(write_data),
        .alu_result(alu_result),
        .pc(pc)
    );

    data_mem #(
        .ADDRESS_WIDTH(32),
        .DATA_WIDTH(32)
    ) dm (
        .clk(clk),
        .n_clr(1'b1),
        .write_en(mem_write),
        .data_in(write_data),
        .addr(alu_result),
        .data_out(read_data)
    );

    // Instantiate the instruction memory module
instr_mem #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH), // Set the address width to 32 bits
    .INSTR_WIDTH(INSTR_WIDTH),   // Set the instruction width to 32 bits
    .PROGRAM(PROGRAM)           // Set the program file to PROGRAM
) instruction_memory (
    .addr(pc), // Address input wire
    .instr(instr) // Fetched instruction output wire
);

endmodule
