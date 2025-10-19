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


module inst_decoder (
    input logic [31:0] instruction,
    output logic [31:0] Rn,
    output logic [31:0] Rd
);    
    logic [3:0] Rn;
    logic [3:0] Rd;
    
endmodule
