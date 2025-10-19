`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 09:28:28 PM
// Design Name: 
// Module Name: addr_inc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Asynchronous address incrementer 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addr_inc #(
    parameter int WIDTH    = 32
)(
    input logic [31:0]     addr_in,
    input logic                 incr_mode, // 1 -> +2, 0 -> +4
    output logic [31:0]    addr_out
);

    always_comb @(*) begin
        if (incr_mode) begin
            addr_out = addr_in + 'd2;
        end else begin
            addr_out = addr_in + 'd4;
        end
    end

endmodule
