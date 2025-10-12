`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2025 03:45:52 PM
// Design Name: 
// Module Name: Register
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


module Register #(
    parameter int WIDTH = 32    // Number of bits (default = 8)
)(
    input  logic                 clk,     // Clock
    input  logic                 rst_n,   // Active-low reset
    input  logic [WIDTH-1:0]     d,       // Data input
    input  logic                 load,    // Load enable
    output logic [WIDTH-1:0]     q        // Data output
);

    // Sequential logic for register operation
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= '0;             // Reset to all zeros
        else if (load)
            q <= d;              // Load input data
    end

endmodule
