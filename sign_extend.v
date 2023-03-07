`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 08:06:15 AM
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input [31:7] instr_part,                        // Input instruction part with most significant bits unused
    input [1:0] imm_src,                            // Selects the type of immediate value to be generated
    output reg [31:0] data_out_signed               // Output signed data with the specified immediate value
    );

    localparam [1:0] i_type = 2'b00,                // Immediate type
                     s_type = 2'b01,                // Store type
                     b_type = 2'b10;                // Branch type

    always @(*) begin                                // Executes whenever the inputs change
        data_out_signed = 0;                        // Initialize the output to zero
        case (imm_src) 
            i_type: data_out_signed = {{20{instr_part[31]}}, instr_part[31:20]};    // Generate an immediate for i-type instructions
            s_type: data_out_signed = {{20{instr_part[31]}}, instr_part[31:25], instr_part[11:7]};    // Generate an immediate for s-type instructions
            b_type: data_out_signed = {{20{instr_part[31]}}, instr_part[7], instr_part[30:25], instr_part[11:8], 1'b0};    // Generate an immediate for b-type instructions
        endcase
    end
endmodule


