`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:02:24 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [6:0] op,                // input signal for the opcode
    input wire [2:0] funct3,       // input signal for the function code (3 bits)
    input wire funct7, zero, sign, // input control signals (1 bit each)
    output wire  result_src, mem_write, alu_src, reg_write, load,  // output control signals
    output wire [1:0] imm_src, // output signal for immediate source (2 bits)
    output wire [2:0] alu_control, // output signal for ALU control (3 bits)
    output reg pc_src
);

    reg  branch_mux_out; // declare registers for branch control signals
    wire branch;
    wire [1:0] alu_op;
    // instantiate the main_decoder module
    main_decoder decoder_inst (
        .op(op),          // input 7-bit opcode signal
        .branch(branch),  // output control signal for branch
        .result_src(result_src),  // output control signal for result source
        .mem_write(mem_write),  // output control signal for memory write
        .alu_src(alu_src),  // output control signal for ALU source
        .reg_write(reg_write),  // output control signal for register write
        .imm_src(imm_src),  // output control signal for immediate source
        .alu_op(alu_op),    // output control signal for ALU operation
        .load(load) // output load signal for PC
    );
// Instantiate alu_decoder module and connect its inputs and outputs
    alu_decoder alu_decoder_inst (
        .alu_op(alu_op),           // Connect alu_op input to alu_op output of previous module
        .funct3(funct3),           // Connect funct3 input to funct3 output of previous module
        .op5(op[5]),                 // Connect op5 input to op5 output of previous module
        .funct7(funct7),           // Connect funct7 input to funct7 output of previous module
        .alu_control(alu_control)  // Connect alu_control output to alu_control input of next module
    );

    // implementing pc src logic
    localparam [2:0]    beq = 3'b000,   
                        bnq = 3'b001,
                        blt = 3'b100;

    always @(*) begin 
        case (funct3) // case statement to determine the branch control signal
            beq:
                pc_src = zero & branch;
            bnq:
                pc_src = ~zero & branch;
            blt:
                pc_src = sign & branch;
            default:
                pc_src = 0;
        endcase
    end

endmodule
