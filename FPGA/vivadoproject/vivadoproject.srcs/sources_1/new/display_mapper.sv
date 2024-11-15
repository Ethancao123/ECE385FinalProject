`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 03:58:11 PM
// Design Name: 
// Module Name: display_mapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_mapper(
    input logic [9:0] drawX, drawY,
    output logic [2:0] red, green, blue,
    output logic [16:0] vram_addr,
    input logic [8:0] vram_data
    );
    
    vram_addr = drawX 
endmodule
