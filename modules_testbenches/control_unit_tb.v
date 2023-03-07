`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 06:25:30 PM
// Design Name: 
// Module Name: control_unit_tb
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


`timescale 1ns / 1ps

module control_unit_tb;

    // Inputs
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7, zero, sign;

    // Outputs
    wire pc_src, result_src, mem_write, alu_src, reg_write;
    wire [1:0] imm_src;
    wire [2:0] alu_control;

    // Instantiate the Unit Under Test (UUT)
    control_unit uut (
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero),
        .sign(sign),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .alu_control(alu_control)
    );

    initial begin

    // ALU decoder test
    
    
    // Test case 1
    op = 7'b000_0011;
    funct3 = 3'b001;
    funct7 = 1'b1;
    zero = 1'b0;
    sign = 1'b1;
    #10;
    $display("Test case 1 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    op = 7'b010_0011;
    funct3 = 3'b111;
    #10;
    $display("Test case 2 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    op = 7'b011_0011;
    #10;

    $display("Test case 3 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    funct3 = 3'b110;
    op = 7'b001_0011;
    #10;

    $display("Test case 4 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    
    op = 7'b110_0011;
    funct3 = 3'b100;
    #10;    
    $display("Test case 5 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    $display("branch = %b, sign= %b",uut.decoder_inst.branch,sign);
    
    zero = 1'b1;
    funct3 = 3'b100;
    #10;
    $display("Test case 6 - Result for op= %b : pc_src=%b, result_src=%b, mem_write=%b, alu_src=%b, reg_write=%b, imm_src=%b, alu_control=%b, alu_op = %b",
              op, pc_src, result_src, mem_write, alu_src, reg_write, imm_src, alu_control, uut.decoder_inst.alu_op);
    $display("branch = %b, zero= %b",uut.decoder_inst.branch, zero);
    #10;
    $finish;
    end

endmodule

