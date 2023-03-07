`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2023 09:08:49 PM
// Design Name: 
// Module Name: instr_mem_tb
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


module instr_mem_tb;

localparam ADDRESS_WIDTH = 32;
localparam INSTR_WIDTH = 32;

reg [ADDRESS_WIDTH-1:0] addr;
wire [INSTR_WIDTH-1:0] instr;

instr_mem dut (
    .addr(addr),
    .instr(instr)
);

task disp_instr(
    input [ADDRESS_WIDTH-1:0] address
);
#10 $display("Instruction at address 0x%x is 0x%x", address, instr);
endtask

initial begin
    // Load test program into memory
    $readmemh("fibbonachi.txt", dut.memory);

    // Test instruction memory reads
        addr = 0;
        disp_instr(addr);
        addr = 4;
        disp_instr(addr);
        addr = 8;
        disp_instr(addr);
        addr = 12;
        disp_instr(addr);
        addr = 16;
        disp_instr(addr);        
        addr = 18;
        disp_instr(addr);
        addr = 20;
        disp_instr(addr);
        addr = 24;
        disp_instr(addr);
        $stop;
end

endmodule

