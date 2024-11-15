`timescale 1ns / 1ps

/////////////////////////////////////////
// Team: DetectoVision
// EC 551 Advanced Digital Design
// Description: top module
/////////////////////////////////////////

module topModule(
    input wire clkMain,
    input wire clk25_reg,
    input wire resetButton,
    input wire pclk,
    input wire href,
    inout wire siod,
    output wire sioc,
    input wire vsync, 
    
    output reg  [14:0] LED,
    output wire reset,
    output wire PWDN,
    output wire xclk,
    output reg pixelValid_verify,
    input  wire [7:0] data,
    
    // display
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output wire VS,
    output wire HS
);
    
    wire clk25_reg;
    wire clk1_reg;
    wire clk_visual;
    wire [15:0] pixelValue;
    wire [3:0] pixelVGA;
    wire [9:0]outX; 
    wire [9:0]outX_vgaOut;
    wire [8:0]outY_vgaOut;
    wire [8:0] outY;
    wire pixelValid;
    
    reg idealStart = 1'b0;
    reg redHue = 1'b0;
    reg edgeOn = 1'b0;
    reg visualSW = 1'b0;
    
    clkDiv_1Hz clkDiv2(
        .clk(clkMain),
        .reset(resetButton),
        .clk25_output(clk1_reg)
    );
    
    clkDiv_visual clkDiv3(
        .clk(clkMain),
        .reset(resetButton),
        .clk25_output(clk_visual)
    );

    cameraControl cam (
        .clk25(clk25_reg),
        .OV7670_D(data),
        .OV7670_HREF(href),
        .OV7670_VSYNC(vsync),
        .OV7670_PCLK(pclk),
        .OV7670_SIOD(siod),
        .OV7670_SIOC(sioc),
        .OV7670_PWDN(PWDN),
        .OV7670_RESET(reset),
        .OV7670_XCLK(xclk),
        .outX(outX),
        .outY(outY),
        .pixelValue(pixelValue),
        .pixelValid(pixelValid)  
    );
    
    
    
    // main module for grey scale and color masking
    frameBuffer_greyScale frame(
        .clk(clkMain),
        .reset(resetButton),
        .redHue(redHue),
        .edgeOn(edgeOn),
        .visualSW(visualSW),
        .inX(outX),
        .inY(outY),
        .outX(outX_vgaOut),
        .outY(outY_vgaOut),
        .inPixel(pixelValue),
        .pixelValid(pixelValid),
        .outPixel(pixelVGA)
    );
    
    
    
    
    
    
    always@(posedge clk_visual)
    begin
        if(idealStart == 1'b0)
            idealStart <= 1'b1;
            
        else
            idealStart <= 1'b0;        
    
    end
    
    
    VGA display(
        .pixel_clk(clk25_reg),
        .redHue(redHue),
        .edgeOn(edgeOn),
        .visualSW(visualSW),
        .idealStart(idealStart),
        .idealX(idealX),
        .idealY(idealY),
        .vgaIn(pixelVGA),
        .outX(outX_vgaOut),
        .outY(outY_vgaOut),
        .VGA_R(red),
        .VGA_G(green),
        .VGA_B(blue),
        .VGA_HS(HS),
        .VGA_VS(VS)
    );
   

endmodule
