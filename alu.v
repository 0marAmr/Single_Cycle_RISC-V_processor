`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Omar Amr
// 
// Create Date: 02/10/2023 09:00:49 PM
// Design Name: Arithmatic-Logic Unit
// Module Name: alu
// Project Name: ALU
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

module alu
#(
        parameter WIDTH = 32
    )(
        input wire [2:0] sel,
        input wire [WIDTH-1: 0] A, B,
        output reg [WIDTH-1: 0] alu_result,
        output reg  sign_flag, zero_flag
    );
    
    localparam  [2:0]   ADD     = 3'b000,
                        SHL     = 3'b001,
                        SUB     = 3'b010,
                        NOTUSED = 3'b011, 
                        XOR     = 3'b100,
                        SHR     = 3'b101,
                        OR      = 3'b110,
                        AND     = 3'b111;

    always @ (*) 
    begin
        alu_result = {WIDTH{1'b0}};
        case(sel)
            ADD: 
            begin
                alu_result = A + B;
            end
            SHL: 
            begin
                alu_result = A << B;
            end
            SUB: 
            begin
                alu_result = A - B;
            end
            XOR: 
            begin
                alu_result = A ^ B;
            end 
            SHR: 
            begin
                alu_result = A >> B;
            end
            OR: 
            begin
                alu_result = A | B;
            end
            AND: 
            begin
                alu_result = A & B;
            end
            default: 
                alu_result = {WIDTH{1'b0}};
        endcase
        
         zero_flag = ~(| alu_result);
         sign_flag =  alu_result[WIDTH-1];
    end
    
endmodule