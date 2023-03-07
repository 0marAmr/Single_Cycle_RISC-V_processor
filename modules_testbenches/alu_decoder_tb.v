`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2023 11:23:48 PM
// Design Name: 
// Module Name: alu_decoder_tb
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


module alu_decoder_tb;

    // Inputs
    reg [1:0] alu_op;
    reg [2:0] funct3;
    reg op5, funct7;

    // Outputs
    wire [2:0] alu_control;

    // Instantiate the module
    alu_decoder uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .op5(op5),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    // Clock signal
    reg clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("for signal %b, the alu control = %b",{alu_op, funct3, op5, funct7},alu_control);
    end
    integer  i;
    // Test stimulus
    initial begin

        // alu control shall remain equal zero
        alu_op = 0;
        funct3 = 0;
        op5 = 0;
        funct7 =0;
        @(negedge clk);
        funct3 = 4;
        op5 = 1;
        funct7 =1;
        @(negedge clk);
        alu_op = 01;
        funct3 = 100;
        @(negedge clk);
        funct3 = 111;
        @(negedge clk);
        alu_op = 10;
        funct3 = 000;
        {op5,funct7} = 01;
        @(negedge clk);
        {op5,funct7} = 11;
        @(negedge clk);
        $display("testing alu operations");
        for (i =0 ; i < 8 ; i = i+1 ) begin
            funct3 = i;
            @(negedge clk);
        end
        
        $finish;
    end

endmodule
