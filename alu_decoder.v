`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:02:24 AM
// Design Name: 
// Module Name: alu_decoder
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


module alu_decoder(
    input wire [1:0] alu_op,       // 2-bit ALU operation code input
    input wire [2:0] funct3,       // 3-bit function code input
    input wire op5, funct7,        // 1-bit opcode 5 and 7 inputs
    output reg [2:0] alu_control   // 3-bit ALU control output
);

    wire [6:0] sel = {alu_op, funct3, op5, funct7};   // Concatenate the inputs for the select statement

    localparam [2:0]   ADD     = 3'b000,    // Local parameter for ADD operation
                       SHL     = 3'b001,    // Local parameter for SHL operation
                       SUB     = 3'b010,    // Local parameter for SUB operation
                       NOTUSED = 3'b011,    // Local parameter for UNUSED operation
                       XOR     = 3'b100,    // Local parameter for XOR operation
                       SHR     = 3'b101,    // Local parameter for SHR operation
                       OR      = 3'b110,    // Local parameter for OR operation
                       AND     = 3'b111;    // Local parameter for AND operation

    always @(*) begin
        casex (sel)                         // Use the concatenated value as selector
            7'b00_???_??: alu_control = ADD;            // lw, sw instructions - set to ADD
            7'b01_000_??, 7'b01_001_??, 7'b01_100_??:  // beq, bnq, blt - set to SUB
                alu_control = SUB;            
            7'b10_000_00, 7'b10_000_01, 7'b10_000_10:  // add, addi, sll - set to ADD
                alu_control = ADD;
            7'b10_000_11: alu_control = SUB;            // sub instruction - set to SUB
            7'b10_001_??: alu_control = SHL;            // shl instruction - set to SHL
            7'b10_100_??: alu_control = XOR;            // xor instruction - set to XOR
            7'b10_101_??: alu_control = SHR;            // shr instruction - set to SHR
            7'b10_110_??: alu_control = OR;             // or instruction - set to OR
            7'b10_111_??: alu_control = AND;            // and instruction - set to AND
            default: 
                alu_control = ADD;                      // Default to ADD if no match
        endcase
    end

endmodule
