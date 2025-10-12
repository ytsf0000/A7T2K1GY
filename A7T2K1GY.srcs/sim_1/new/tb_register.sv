`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2025 04:18:56 PM
// Design Name: 
// Module Name: tb_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Simple register testbench without the use of assertions/scoreboarding
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_register;

    parameter int WIDTH = 32;    
    logic                 clk;
    logic                 rst_n;
    logic                 load;
    logic [WIDTH-1:0]     d;
    logic [WIDTH-1:0]     q;

    Register #(.WIDTH(WIDTH)) dut (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (d),
        .load  (load),
        .q     (q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        rst_n = 0;
        load  = 0;
        d     = '0;

        // Apply reset
        $display("[%0t] Applying reset...", $time);
        #12;
        rst_n = 1;
        $display("[%0t] Releasing reset.", $time);

        // Wait a few cycles
        repeat (2) @(posedge clk);

        // Test 1: Load new value
        d = 'hA5;  // 0xA5 = 10100101 for WIDTH=8
        load = 1;
        @(posedge clk);
        load = 0;

        // Wait a cycle and check output
        @(posedge clk);
        $display("[%0t] After load, q = 0x%0h (expected 0x%0h)", $time, q, d);

        // Test 2: Change input without load
        d = 'h3C;
        @(posedge clk);
        $display("[%0t] load=0, q should remain 0xA5 -> q = 0x%0h", $time, q);

        // Test 3: Load new value again
        d = 'hFF;
        load = 1;
        @(posedge clk);
        load = 0;

        @(posedge clk);
        $display("[%0t] After second load, q = 0x%0h (expected 0xFF)", $time, q);

        // Finish simulation
        #10;
        $display("[%0t] Test completed.", $time);
        $finish;
    end

endmodule