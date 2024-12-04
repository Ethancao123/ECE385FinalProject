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
    logic [8:0] rowreg[170];
    logic [8:0] blocknum;
    assign blocknum = drawX / 40 + (drawY / 40) * 15;
    logic [8:0] maxInd, rollingInd;
    logic [8:0] maxVal;
    assign targetX = (maxInd % 15);
    assign targetY = (maxInd / 15);
    always_ff @(posedge clk) begin
        if(~vsync) begin
            maxVal <= 0;
            for (integer i = 0; i < 170; i = i + 1) begin
                rowreg[i] <= 0;
            end
            maxInd <= rollingInd;
        end else begin
            rowreg[blocknum] <= rowreg[blocknum] + (pixelin > 4);
            if(rowreg[blocknum] > maxVal) begin
                maxVal <= rowreg[blocknum];
                rollingInd <= blocknum;
            end
        end
    end
endmodule
