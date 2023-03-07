`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2023 09:08:49 PM
// Design Name: 
// Module Name: instruction_fetch_unit_tb
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


`timescale 1ns / 1ps

module instruction_fetch_unit_tb;

  // Parameters
  parameter ADDRESS_WIDTH = 32;
  parameter INSTR_WIDTH = 32;
  parameter PROGRAM = "fibonacci.txt";
  parameter N = 32;

  // Inputs
  reg clk;
  reg n_reset;
  reg load;
  reg pc_src;
  reg [1:0] imm_src;

  // Outputs
  wire [INSTR_WIDTH-1:0] instr;
  wire [INSTR_WIDTH-1:0] imm_ext;

  // Instantiate the module
  instruction_fetch_unit #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .INSTR_WIDTH(INSTR_WIDTH),
    .PROGRAM(PROGRAM),
    .N(N)
  ) ifu (
    .clk(clk),
    .n_reset(n_reset),
    .load(load),
    .pc_src(pc_src),
    .imm_src(imm_src),
    .instr(instr),
    .imm_ext(imm_ext)
  );

  // Clock generation
  always #5 clk = ~clk;

task initialize();
begin
    n_reset = 0;
    clk = 0;
    load = 1;
    pc_src = 0;
    imm_src = 0;
    @(negedge clk);
    n_reset = 1;
end
endtask

task sequential_instruction();
begin
    pc_src = 0;
    @(negedge clk);
end
endtask

// Test sequence
initial begin
    initialize();
    sequential_instruction();
    sequential_instruction();
    sequential_instruction();
    sequential_instruction();

    $stop;
end

endmodule

