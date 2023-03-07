`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 08:46:56 PM
// Design Name: 
// Module Name: single_port_BRAM_TB
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

module data_mem_tb;

// single_port_BRAM Parameters
parameter PERIOD  = 10;

parameter DATA_WIDTH = 32;
parameter ADDRESS_WIDTH = 32;

// single_port_BRAM Inputs
reg clk = 0 ;
reg write_en = 0 ;
reg n_clr = 0 ;
reg [DATA_WIDTH-1: 0]  data_in = 0 ;
reg [ADDRESS_WIDTH-1: 0]  addr = 0 ;

// single_port_BRAM Outputs
wire  [DATA_WIDTH-1: 0]  data_out;


initial
begin
    clk = 0;
    forever #(PERIOD/2)  clk=~clk;
end

data_mem  d_memory (
    .clk(clk),
    .write_en(write_en),
    .n_clr(n_clr),
    .data_in(data_in),
    .addr(addr),
    .data_out(data_out)
);

task initialize_memory();
    begin
    write_en =0;
    n_clr = 0;
    data_in = 0;
    addr = 0;
    @(negedge clk);
    n_clr = 1;
    end
endtask

task mem_write (
    input reg [ADDRESS_WIDTH-1: 0] address,
    input reg [DATA_WIDTH-1: 0] data
);
    begin
    write_en = 1;
    data_in = data;
    addr = address;
    @(negedge clk);
    write_en =0;
    data_in = 0;
    addr = 0;
    end
endtask

task mem_read(
    input reg [ADDRESS_WIDTH-1: 0] address
);
    begin
    addr =  address;
    @(negedge clk);
    addr =  0;
    end
endtask

initial
begin
    initialize_memory();
    
    mem_write(20, 10);
    mem_write(25, 22);
    mem_write(0, 87);

    mem_read(20);
    mem_read(0);
    mem_read(25);
    $finish;
end

endmodule
