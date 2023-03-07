`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 01:13:02 PM
// Design Name: 
// Module Name: sign_extend_tb
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

module sign_extend_tb;

    // Parameters
    localparam INST_LEN = 32;

    // Inputs
    reg [31:7] instr_part;
    reg [1:0] imm_src;
    reg clk;

    // Outputs
    wire [INST_LEN-1:0] data_out_signed;
    

    // Instantiate the Unit Under Test (UUT)
    sign_extend uut (
        .instr_part(instr_part),
        .imm_src(imm_src),
        .data_out_signed(data_out_signed)
    );

    // Initialize Inputs
    initial begin
        instr_part = 32'h12345678;
        imm_src = 2'b01; // s_type
    end

    // Stimulus
    always #10 imm_src = (imm_src + 1) % 3;

    // Print Output
    always @(posedge clk) $display("data_out_signed = %h", data_out_signed);

    // Clock
    initial begin
        clk =0;
        forever #5 clk = ~clk;
    end

endmodule
 
