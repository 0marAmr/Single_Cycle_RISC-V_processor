`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: data_path
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


module data_path
#(  parameter   W = 5,
                 B = 32, 
                 WIDTH = 32
)(
    input wire clk, n_reset,                  // clock and reset inputs
    input wire [W-1: 0] r_addr_A, r_addr_B, w_addr,  // read and write address inputs
    input wire [WIDTH-1: 0] imm_ext, read_data,       // immediate extension and read data inputs
    input wire alu_src, reg_write, result_src,        // ALU source, register write, and result source inputs
    input wire [2:0] alu_control,              // ALU control input
    output wire zero, sign,                    // ALU zero and sign flags outputs
    output wire [WIDTH-1: 0] write_data, alu_result, result        // write data output
);

    // parameterize the module with W = 5 and B = 32
    

    // instantiate a register file module with 5-bit read/write addresses and 32-bit words
    wire [WIDTH-1: 0] src_A, src_B, r_data_B;
    reg_file #(
        .W(W),
        .B(B)
    ) register_file (
        // input ports
        .r_addr_A(r_addr_A),   // read address A input
        .r_addr_B(r_addr_B),   // read address B input
        .w_addr(w_addr),       // write address input
        .clk(clk),             // clock input
        .wr_en(reg_write),     // write enable input
        .n_reset(n_reset),     // reset input
        .w_data(result),       // write data input
        // output ports
        .r_data_A(src_A),      // read data A output
        .r_data_B(r_data_B)    // read data B output
    );

    // instantiate a mux module for selecting between immediate extension and register B data as the source for the ALU's second input
    mux #(.N(32))src_B_mux
    (
        .data_true(imm_ext),   // immediate extension input
        .data_false(r_data_B), // register B data input
        .sel(alu_src),         // select immediate extension if alu_src is 1, else select register B data
        .data_out(src_B)       // output selected data
    );

    // instantiate an ALU module
    alu #(
        .WIDTH(WIDTH) // set WIDTH parameter to 32 bits
    ) alu_inst (
        .sel(alu_control),               // input for selecting operation (addition)
        .A(src_A),               // input A
        .B(src_B),               // input B
        .alu_result(alu_result),    // output of the ALU operation
        .sign_flag(sign),           // output sign flag
        .zero_flag(zero)            // output zero flag
    );

    // instantiate a mux module for selecting between read data and ALU result as the output of the data path
    mux #(.N(32))result_mux
    (
        .data_true(read_data),   // read data input
        .data_false(alu_result), // ALU result input
        .sel(result_src),        // select read data if result_src is 0, else select ALU result
        .data_out(result)        // output selected data
    );
    
    // assign register B data as the output write data
    assign write_data = r_data_B;
    
endmodule
