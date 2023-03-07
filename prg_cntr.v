`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2023 08:06:15 AM
// Design Name: 
// Module Name: prg_cntr
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


module prg_cntr
#(  parameter N = 32   // Parameter defining the number of bits for the PC counter
)(
    input wire clk, n_reset,  // Clock and reset inputs
    input load,  // Load input for setting a new PC value
    input [N-1: 0] pc_next,  // Input for the next PC value to be loaded
    output wire [N-1: 0] pc  // Output for the current PC value
    );

    reg [N-1: 0] current_pc;   // Register to hold the current PC value

    always @(posedge clk or negedge n_reset) begin   // On every positive edge of the clock, or on a negative edge of reset
        if (!n_reset) begin   // If reset is active (low)
            current_pc <= 0;   // Reset the current PC value to zero
        end
        else if(load) begin   // If load is active (high)
            current_pc <= pc_next;   // Set the current PC value to the new PC value (pc_next)
        end
    end
    assign pc = current_pc;
endmodule
