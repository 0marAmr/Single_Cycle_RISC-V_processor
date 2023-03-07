`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 02:52:36 AM
// Design Name: 
// Module Name: top_tb
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


module tb_top_module();

    reg clk, n_reset;

    top_module dut (
        .clk(clk),
        .n_reset(n_reset)
    );


    // clock signal
    parameter PERIOD  = 20;

    initial begin
        clk = 0;
        forever #(PERIOD/2)  clk=~clk; 
    end

    // reset pulse
    initial begin
        n_reset = 1'b0;
        #(PERIOD/2);
        n_reset = 1'b1;
    end

    initial begin
        repeat(200)@(negedge clk);

        $finish;
    end

endmodule

