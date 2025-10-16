`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 09:52:47 PM
// Design Name: 
// Module Name: inst_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Instruction Decoder
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module inst_decoder #(
    parameter WIDTH = 32,
    parameter REG_WIDTH = 4
)(
    input logic [WIDTH-1:0] instruction
);    
    logic [REG_WIDTH-1:0] Rn;
    logic [REG_WIDTH-1:0] Rd;
    
endmodule
