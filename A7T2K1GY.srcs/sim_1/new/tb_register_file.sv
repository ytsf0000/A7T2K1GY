`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2025 05:16:54 PM
// Design Name: 
// Module Name: tb_register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Register file testbench
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_register_file;

    parameter int WIDTH    = 32;
    parameter int NUM_REGS = 31;
    localparam int ADDR_WIDTH = $clog2(NUM_REGS);

    logic                     clk;
    logic                     rst_n;
    logic                     write_en;
    logic [ADDR_WIDTH-1:0]    write_addr;
    logic [ADDR_WIDTH-1:0]    read_addr;
    logic [WIDTH-1:0]         write_data;
    logic [WIDTH-1:0]         read_data;

    // Reference array for checking correctness
    logic [WIDTH-1:0] ref_mem [NUM_REGS-1:0];


    register_file #(
        .WIDTH(WIDTH),
        .NUM_REGS(NUM_REGS)
    ) dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .write_en   (write_en),
        .write_addr (write_addr),
        .read_addr  (read_addr),
        .write_data (write_data),
        .read_data  (read_data)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period

    initial begin
        integer i;
        rst_n      = 0;
        write_en   = 0;
        write_addr = 0;
        read_addr  = 0;
        write_data = 0;

        for (i = 0; i < NUM_REGS; i++)
            ref_mem[i] = 0;

        // Apply reset
        #12;
        rst_n = 1;

        // Write to each register using address decimal value * 10, then read
        for (i = 0; i < NUM_REGS; i++) begin
            // Write
            write_en   = 1;
            write_addr = i[ADDR_WIDTH-1:0];
            write_data = i * 10;
            @(posedge clk);       // Write happens here
            write_en = 0;         // Disable write
            ref_mem[i] = write_data;

            // Wait one extra clock cycle before reading
            @(posedge clk);
            read_addr = i[ADDR_WIDTH-1:0];
            @(posedge clk);       // Read happens here

            // Check
            if (read_data !== ref_mem[i])
                $error("[%0t] ERROR - Mismatch at addr %0d: read_data=0x%0h, expected=0x%0h",
                        $time, i, read_data, ref_mem[i]);
            else
                $display("[%0t] PASSED - Read addr %0d correctly: 0x%0h", $time, i, read_data);
        end

        // Random write
        repeat (NUM_REGS) begin
            write_en   = 1;
            write_addr = $urandom_range(0, NUM_REGS-1);
            write_data = $urandom_range(0, 2**WIDTH-1);
            @(posedge clk);
            write_en = 0;
            ref_mem[write_addr] = write_data;
            @(posedge clk); // wait one cycle before reading
        end

        // Random read check
        repeat (NUM_REGS) begin
            read_addr = $urandom_range(0, NUM_REGS-1);
            @(posedge clk);
            if (read_data !== ref_mem[read_addr])
                $error("[%0t] ERROR - Random mismatch at addr %0d: read_data=0x%0h, expected=0x%0h",
                        $time, read_addr, read_data, ref_mem[read_addr]);
            else
                $display("[%0t] PASSED - Random read addr %0d correctly: 0x%0h", $time, read_addr, read_data);
        end

        $display("[%0t] PASSED - Testbench completed successfully.", $time);
        $finish;
    end

endmodule
