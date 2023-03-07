`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(
    input [6:0]op, // 7-bit input signal op
    output reg branch, result_src, mem_write, alu_src, reg_write, load, // output control signals 
    output reg [1:0] imm_src, alu_op // output control signals with 2 bits
);

    localparam [6:0]    load_word   = 7'b000_0011,  // opcode for loading a word from memory
                        store_word  = 7'b010_0011,  // opcode for storing a word into memory
                        r_type      = 7'b011_0011,  // opcode for R-type instructions
                        i_type      = 7'b001_0011,  // opcode for I-type instructions
                        branch_inst = 7'b110_0011,  // opcode for branch instructions
                        halt = 7'b000_000;          // opcode for halt instruction that stop the pc increment
                    
    always @(*) begin // combinational always block
        load = 1'b1;
        case (op) // decode the opcode

            load_word: begin // if the opcode is for loading a word
                reg_write = 1'b1; // enable register write
                imm_src = 2'b00; // use immediate value of instruction for sign extension
                alu_src = 1'b1; // use the immediate value as the ALU source
                mem_write = 1'b0; // do not write to memory
                result_src = 1'b1; // use the ALU result as the result source
                branch = 1'b0; // do not take a branch
                alu_op = 2'b00; // use the add operation for the ALU
            end 
            store_word: begin // if the opcode is for storing a word
                reg_write = 1'b0; // disable register write
                imm_src = 2'b01; // use the immediate value of the instruction as the offset
                alu_src = 1'b1; // use the immediate value as the ALU source
                mem_write = 1'b1; // enable memory write
                result_src = 1'b0; // the result source is undefined for stores
                branch = 1'b0; // do not take a branch
                alu_op = 2'b00; // use the add operation for the ALU
            end 
            r_type: begin // if the opcode is for R-type instructions
                reg_write = 1'b1; // enable register write
                imm_src = 2'b00; // do not use an immediate value
                alu_src = 1'b0; // use the values from the registers as the ALU source
                mem_write = 1'b0; // do not write to memory
                result_src = 1'b0; // use the ALU result as the result source
                branch = 1'b0; // do not take a branch
                alu_op = 2'b10; // use the function code of the instruction for the ALU operation
            end 
            i_type: begin // if the opcode is for I-type instructions
                reg_write = 1'b1; // enable register write
                imm_src = 2'b00; // use immediate value of instruction for sign extension
                alu_src = 1'b1; // use the immediate value as the ALU source
                mem_write = 1'b0; // do not write to memory
                result_src = 1'b0; // use the ALU result as the result source
                branch = 1'b0; // do not take a branch
                alu_op = 2'b10;
            end             
            branch_inst: begin // if the opcode is for I-type instructions
                reg_write = 1'b0; // enable register write
                imm_src = 2'b10; // use immediate value of instruction for sign extension
                alu_src = 1'b0; // use the immediate value as the ALU source
                mem_write = 1'b0; // do not write to memory
                result_src = 1'b0; // use the ALU result as the result source
                branch = 1'b1; // do not take a branch
                alu_op = 2'b01;
            end 
            halt: begin
                load = 1'b0;
                reg_write = 1'bx;
                imm_src = 2'bxx;
                alu_src = 1'bx;
                mem_write = 1'bx;
                result_src = 1'bx;
                branch = 1'bx;
                alu_op = 2'bxx;
            end            
            default: begin
                reg_write = 1'b0;
                imm_src = 2'b00;
                alu_src = 1'b0;
                mem_write = 1'b0;
                result_src = 1'b0;
                branch = 1'b0;
                alu_op = 2'b00;
            end
        endcase
    end
endmodule
