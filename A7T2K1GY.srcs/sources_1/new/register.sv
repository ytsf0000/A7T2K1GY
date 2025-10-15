`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2025 06:55:42 PM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Register module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register #(
    parameter int WIDTH = 32
)(
    input  logic                 clk,     // Clock
    input  logic                 rst_n,   // Active-low reset
    input  logic [WIDTH-1:0]     d,       // Data input
    input  logic                 load,    // Load enable
    output logic [WIDTH-1:0]     q        // Data output
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= '0;             
        else if (load)
            q <= d;              
    end

endmodule
