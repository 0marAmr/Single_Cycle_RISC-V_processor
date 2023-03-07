`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 07:58:00 PM
// Design Name: 
// Module Name: single_port_BRAM
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


module data_mem
#(parameter ADDRESS_WIDTH = 32, 
            DATA_WIDTH = 32
    )(
        input wire clk, n_clr,
        input wire write_en,
        input wire [DATA_WIDTH-1: 0] data_in,
        input wire [ADDRESS_WIDTH-1: 0] addr,
        output wire [DATA_WIDTH-1: 0] data_out
    );

    localparam DEPTH = 64;

    // memory
    reg [DATA_WIDTH-1: 0] data_mem  [DEPTH-1: 0] ;
    reg [DATA_WIDTH-1: 0] data ;

    integer i;

    always @(posedge clk) begin
        if(~n_clr) 
            for (i= 0 ; i < DEPTH ; i = i + 1 ) begin
                data_mem  [i] <= 0;
            end
        else if(write_en)
            data_mem  [addr[31:2]] <= data_in;
    end

    always @ * begin
            data = data_mem [addr[31:2]];
    end
    
    assign data_out = data;
endmodule
