`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 04:18:41 PM
// Design Name: 
// Module Name: target
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


module target(
        input logic clk,
        input logic [9:0] drawX,
        input logic [9:0] drawY,
        input logic [3:0] pixelin,
        output logic [9:0] targetX,
        output logic [9:0] targetY,
        input logic vsync
    );
    //15x10
    logic [8:0] rowreg [149:0];
    assign blocknum = drawX / 15 + drawY * 15 / 10;
    logic [7:0] maxInd;
    logic [8:0] maxVal;
    assign targetX = (maxInd % 15) * 40;
    assign targetY = (maxInd / 15) * 40;
    always_ff @(posedge clk) begin
        if(~vsync) begin
//            maxInd <= 75;
            maxVal <= 0;
            for (int i = 0; i < 150; i = i + 1) begin
                rowreg[i] <= 0;
            end
        end else begin
            rowreg[blocknum] <= rowreg[blocknum] + (pixelin > 4);
            if(rowreg[blocknum] > maxVal) begin
                maxVal <= rowreg[blocknum];
                maxInd <= blocknum;
            end
        end
    end
endmodule
