`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2025 05:07:55 PM
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Register file
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file #(
    parameter int WIDTH    = 32,   // Bits per register
    parameter int NUM_REGS = 31    // Number of registers
)(
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic                       write_en,   // Write enable
    input  logic [$clog2(NUM_REGS)-1:0] write_addr,// Register index to write
    input  logic [$clog2(NUM_REGS)-1:0] read_addr, // Register index to read
    input  logic [WIDTH-1:0]           write_data, // Data to write
    output logic [WIDTH-1:0]           read_data   // Data output
);

    logic [WIDTH-1:0] reg_d   [NUM_REGS];
    logic [WIDTH-1:0] reg_q   [NUM_REGS];
    logic             reg_load[NUM_REGS];

    // Generate registers
    genvar i;
    generate
        for (i = 0; i < NUM_REGS; i++) begin : gen_registers
            // Each register has its own load signal
            assign reg_load[i] = (write_en && (write_addr == i));

            // Instantiate the parameterized register
            register #(.WIDTH(WIDTH)) reg_inst (
                .clk   (clk),
                .rst_n (rst_n),
                .d     (write_data),
                .load  (reg_load[i]),
                .q     (reg_q[i])
            );
        end
    endgenerate

    // Read data output
    assign read_data = reg_q[read_addr];

endmodule