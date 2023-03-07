`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:    Omar Amr
// 
// Create Date: 02/10/2023 09:41:13 PM
// Design Name: 
// Module Name: alu_TB
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


module alu_tb;

    parameter N = 32;
        localparam  [2:0]   ADD     = 3'b000,
                        SHL     = 3'b001,
                        SUB     = 3'b010,
                        NOTUSED = 3'b011, 
                        XOR     = 3'b100,
                        SHR     = 3'b101,
                        OR      = 3'b110,
                        AND     = 3'b111;
    // inputs
    reg [2:0] sel;
    reg [N-1 : 0] A, B;
    
    // outputs
    wire [N-1: 0] alu_result;
    wire sign_flag, zero_flag;
    
    alu #(.N(N)) uut(
        .sel(sel),
        .A(A),
        .B(B),
        .alu_result(alu_result),
        .sign_flag(sign_flag),
        .zero_flag(zero_flag)
    );
    
    task alu_op (
        input [2:0]  operation,
        input [N-1: 0]  Operand1, Operand2
    );
    begin
        sel = operation;
        A = Operand1;
        B = Operand2;
    end
    endtask
    
    integer i;
    localparam ALU_OPERATIONS = 8;
    localparam OP1 = 6;
    localparam OP2 = 5;
    task test_all_operations();
        for (i = 0; i <ALU_OPERATIONS; i = i + 1) begin
            alu_op(i, OP1, OP2);
            #20;
        end
    endtask

    initial begin
        //test_all_operations();

        // result = 1024
        alu_op(ADD, 512, 512);
        #20;

        // result = 64
        alu_op(SHL, 16, 4);
        #20;
        
        // SF = 1 
        alu_op(SHL, 31, 4);
        #20;

        // ZF = 1
        alu_op(SUB, 5, 5);
        #20;
        
        // result = -1024
        alu_op(SUB, 1024, 2048);
        #20;        

        // XOR: complement
        alu_op(XOR, 32'b0110_1010_1010, -32'b1); // 11111.. (mask)
        #20;    
        
        // result = 2 (divide by 2)
        alu_op(SHR, 4, 1); // 11111.. (mask)
        #20;        
        
        // result = 0
        alu_op(NOTUSED, 4, 1); 
        #20;        
        
        
        $stop;
    end
endmodule
