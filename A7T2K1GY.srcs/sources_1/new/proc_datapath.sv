`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 09:37:58 PM
// Design Name: 
// Module Name: proc_datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Processor datapath
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module proc_datapath(
        
    );
    
    // Register File
    register_file Register_File (
        
    );
    
    // Address Increment
    addr_inc Address_Incr (
    
    );
    
    // ALU
    alu ALU (
    
    );
    
    // Instruction Decoder
    inst_decoder Instruction_Decoder (
    
    );
    
    // Pipeline Registers (might move this to a separate module)
    fetch_pipereg Fetch (
    
    );
    
    decode_pipereg Decode (
    
    );
    
    execute_pipereg Execute (
    
    );
    
endmodule
