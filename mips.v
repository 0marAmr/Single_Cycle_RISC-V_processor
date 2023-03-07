`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: mips
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


module mips(
        input wire clk, n_reset,                  // clock and reset inputs
        input wire [31:0] read_data, instr,
        output wire mem_write,
        output wire [31:0] write_data, alu_result, pc
    );

    wire [31:0] instr, imm_ext, result;
    wire [2:0] alu_control;
    wire [1:0] imm_src;

    data_path dp (
        // input ports
        .clk(clk),
        .n_reset(n_reset),
        .r_addr_A(instr[19:15]),
        .r_addr_B(instr[24:20]),
        .w_addr(instr[11:7]),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .imm_ext(imm_ext),
        .alu_control(alu_control),
        .read_data(read_data),
        .result_src(result_src),
        // output ports
        .zero(zero),
        .sign(sign),
        .write_data(write_data),
        .alu_result(alu_result),
        .result(result)
    );

        control_unit cu (
        // input ports
        .op(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7(instr[30]),
        .zero(zero),
        .sign(sign),
        // output ports
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .imm_src(imm_src),
        .reg_write(reg_write),
        .load(load) // output load signal for PC
    );

    instruction_fetch_unit #(
        .ADDRESS_WIDTH(32),
        .INSTR_WIDTH(32),
        .N(32)
    ) ifu (
        // input ports
        .clk(clk),
        .n_reset(n_reset),
        .load(load),
        .pc_src(pc_src),
        .imm_src(imm_src),
        .instr(instr),
        // output ports
        .imm_ext(imm_ext),
        .pc(pc)
    );

endmodule
