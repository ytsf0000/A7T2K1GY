`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2025 08:51:26 PM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 32 x 8 Multiplier
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplier(
    input  logic [31:0] a,     // 32-bit multiplicand
    input  logic [7:0]  b,     // 8-bit multiplier
    output logic [39:0] product // 40-bit product
);

    always_comb begin
        product = a * b;
    end

endmodule
