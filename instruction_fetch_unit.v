`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 11:19:25 AM
// Design Name: 
// Module Name: instruction_fetch_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  This is a module for the Instruction Fetch Unit (IFU)
//  It retrieves the instruction from the memory and prepares it for execution
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_fetch_unit
#(
parameter ADDRESS_WIDTH = 32, // Defines the number of bits for the memory address
parameter INSTR_WIDTH = 32, // Defines the number of bits for the instruction
parameter N = 32 // Parameter defining the number of bits for the PC counter
)(
input wire clk, n_reset, // Clock and reset inputs
input wire load, pc_src, // Load input for setting a new PC value
input wire [1:0] imm_src, // immediate source
input wire [INSTR_WIDTH-1: 0] instr,
output wire [ADDRESS_WIDTH-1: 0] pc, // program counter output
output wire [INSTR_WIDTH-1:0] imm_ext
);
wire [N-1: 0]  pc_next, pc_plus_4, pc_target, imm_ext_internal;

// Instantiate the program counter module
prg_cntr #(.N(N)) program_counter (
    .clk(clk),        // Clock input
    .n_reset(n_reset),  // Reset input
    .load(load),      // Load input
    .pc_next(pc_next),  // Next PC output
    .pc(pc)           // Current PC output
);

// Calculate the PC+4 value
addr #(.N(32)) pc_plus_4_addr (
    .X(pc),
    .Y(4),
    .Z(pc_plus_4)
);    

// Sign-extend the immediate value for arithmetic operations
sign_extend extended (
    .instr_part(instr[31:7]), // Immediate value extracted from the instruction
    .imm_src(imm_src),  // Source of the immediate value
    .data_out_signed(imm_ext_internal)  // Sign-extended immediate value output
);

// Calculate the target PC for a branch or jump instruction
addr #(.N(32)) pc_target_addr (
    .X(pc),
    .Y(imm_ext_internal),
    .Z(pc_target)
);

// Select the next PC value based on the instruction type
mux pc_next_mux (
    .data_true(pc_target),  // Target PC
    .data_false(pc_plus_4),  // PC+4
    .sel(pc_src),  // Source of the next PC value
    .data_out(pc_next)  // Next PC output
);

assign imm_ext = imm_ext_internal;

endmodule
