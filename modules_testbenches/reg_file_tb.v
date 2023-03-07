`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2023 03:05:46 PM
// Design Name: 
// Module Name: register_file_TB
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


module reg_file_tb;
        parameter W = 5, B = 32;
        reg [W-1 : 0] r_addr_A, r_addr_B, w_addr;
        reg clk, wr_en, n_reset;
        reg [B-1 : 0] w_data;
        wire [B-1 : 0] r_data_A, r_data_B;
        
        reg_file #(.W(W), .B(B)) uut  (
            .r_addr_A(r_addr_A), 
            .r_addr_B(r_addr_B), 
            .w_addr(w_addr), 
            .clk(clk), 
            .wr_en(wr_en),
            .n_reset(n_reset), 
            .w_data(w_data), 
            .r_data_A(r_data_A), 
            .r_data_B(r_data_B)
        );

        always #15 clk = ~clk;

        task init_reg_file();
        begin
            clk = 0;
            r_addr_A =0;
            r_addr_B = 0;
            w_addr = 0;
            wr_en = 0;
            n_reset = 0;
            w_data  = 0;
            @(negedge clk);
            n_reset = 1;
        end
        endtask

        task reg_write(
            input [W-1: 0] address,
            input [B-1: 0] data
        );
            begin
                wr_en = 1;
                w_addr = address;
                w_data = data;
                @(negedge clk);
                wr_en = 0;
                w_addr = 0;
                w_data = 0;
            end
        endtask

        task reg_read(
            input [W-1: 0] addr1, addr2
        );
        begin
            r_addr_A = addr1;
            r_addr_B = addr2;
        end
        endtask

        initial begin
        
            init_reg_file();
            reg_write(0,10);
            reg_write(1,15);
            
            reg_read(0,1);
            repeat(2) @(negedge clk);
            
            reg_write(20,100);
            reg_write(21,200);
            
            reg_read(20,21);
            repeat(2) @(negedge clk);

            $stop;
        end
endmodule
