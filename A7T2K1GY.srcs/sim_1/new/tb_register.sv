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
// Description: Simple register testbench with scoreboarding and assertions.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_register;

    parameter int WIDTH = 8;

    logic                 clk;
    logic                 rst_n;
    logic                 load;
    logic [WIDTH-1:0]     d;
    logic [WIDTH-1:0]     q;

    // Reference model expected value
    logic [WIDTH-1:0]     q_ref;

    Register #(.WIDTH(WIDTH)) dut (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (d),
        .load  (load),
        .q     (q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    // Scoreboard behaviour
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q_ref <= '0;
        else if (load)
            q_ref <= d;
    end

    // Assertions, check that DUT output matches expected output after reset is released
    property p_register_correct;
        @(posedge clk) disable iff (!rst_n)
            q == q_ref;
    endproperty

    assert property (p_register_correct)
        else $error("[%0t] Register output mismatch! q=%0h expected=%0h", $time, q, q_ref);

    // Stimulus
    initial begin
        // Initialize
        rst_n = 0;
        load  = 0;
        d     = '0;

        // Reset phase
        $display("[%0t] Applying reset...", $time);
        #12 rst_n = 1;
        $display("[%0t] Releasing reset.", $time);

        // Wait for a few cycles
        repeat (2) @(posedge clk);

        // Test 1: Load value
        d = 'hA5;
        load = 1;
        @(posedge clk);
        load = 0;
        @(posedge clk);

        // Test 2: Change input without load
        d = 'h3C;
        @(posedge clk);

        // Test 3: Load new value
        d = 'hFF;
        load = 1;
        @(posedge clk);
        load = 0;

        // Test 4: Reset in the middle of operation
        #3 rst_n = 0;
        @(posedge clk);
        rst_n = 1;
        @(posedge clk);

        // Wait a bit and finish
        #10;
        $display("[%0t] : PASSED - Test completed with all checks passing.", $time);
        $finish;
    end

endmodule