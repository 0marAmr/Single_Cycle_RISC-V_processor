`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2023 09:46:17 PM
// Design Name: register file
// Module Name: reg_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: a 2^W * B register file
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
/*
             W specifies the number of address bits (hence the number of registers in the file), 
             B specifies the number of bits in a word (size of each register).
             The write address signal, w_addr, specifies where to store data.
             the read address signal, r_addr, specifies where to retrieve data.
             write enable signal wr_en, enables writing to the register file
*/
// 
//////////////////////////////////////////////////////////////////////////////////


module reg_file
    #(parameter W = 5,           // address bits
                B = 32           // bits per word 
     )
    (       
        input wire [W-1 : 0] r_addr_A, r_addr_B, w_addr,
        input wire clk, wr_en, n_reset,
        input wire [B-1 : 0] w_data,
        output wire [B-1 : 0] r_data_A, r_data_B
    );

    // storage elements
    reg [B-1 : 0] array_reg [2**W-1 : 0];
    integer i;
    always @(posedge clk or negedge n_reset)  begin
        if(~n_reset)
            for (i = 0; i < 2**W ; i = i + 1) begin
                array_reg[i] <= 0;
            end
        else if(wr_en) 
            array_reg[w_addr] <= w_data;
    end
    
    assign r_data_A = array_reg[r_addr_A];
    assign r_data_B = array_reg[r_addr_B];

endmodule
