module TrackerTopLevel (
    output logic Servo1PWM,
    output logic Servo2PWM,
    input logic [15:0] sw_i,
    input logic clkin,
    input logic reset_rtl_0,
    
    input logic camera_pixel_clock,
    input logic camera_vsync,
    input logic camera_href,
    input logic [7:0] camera_datain,
    output logic camera_clock,
    output logic i2c_scl,
    output logic i2c_sda,
    output logic camera_reset_sig,
    output logic pwdn,
    
    output logic hdmi_tmds_clk_n, hdmi_tmds_clk_p,
    output logic [2:0] hdmi_tmds_data_n, hdmi_tmds_data_p
);

    logic reset;
    logic clk_out25Mhz;
    logic clk_out125Mhz;
    logic clk_out180Mhz;
    logic clk_locked;
    logic start_config;
    logic config_done;
    assign reset = reset_rtl_0;
    logic [15:0] camera_to_vram;
    
    logic [3:0] red;
    logic [3:0] green;
    logic [3:0] blue;
    logic [3:0] vid_pixel, red_pixel;
    logic [17:0] vid_address;
    logic pixel_valid;
    logic vid_vsync;
    logic vid_hsync;
    logic vid_vde;
    logic [9:0] vid_drawX, vid_drawY; 
    logic [15:0] tarX, tarY;
    
    logic [16:0] cam_vramb_addr;
    logic [8:0] cam_vramb_data;
    
    logic [31:0] servo_out;
    logic [31:0] target_in;
    
    assign target_in = {tarX, tarY};
    
    design_1 blk_design(
        .clk_100MHz(clk),
        .reset_rtl_0(reset),
        
        .gpio_out(servo_out),
        .gpio_in(target_in)
    );
    
    
    servo_driver driver1(
        .clk_180MHz(clk_out180Mhz),
        .reset(reset),
        .angle(servo_out[7:0]),
        .PWM(Servo1PWM)
    );
    
    servo_driver driver2(
        .clk_180MHz(clk_out180Mhz),
        .reset(reset),
        .angle(servo_out[31:16]),
        .PWM(Servo2PWM)
    );
    
    clk_wiz_1 clk_wiz_1(
        .reset(reset),
        .clk_in1(clkin),
        .clk_out1(clk_out125Mhz),
        .clk_out2(clk_out25Mhz),
        .clk_out3(clk_out180Mhz),
        .clk_out4(clk),
        .locked(clk_locked)
    );


    topModule camera_top (
        .clkMain(clk),
        .clk25_reg(clk_out25Mhz),
        .resetButton(reset),
        .pclk(camera_pixel_clock),
        .href(camera_href),
        .sioc(i2c_scl),
        .siod(i2c_sda),
        .vsync(camera_vsync), 
    
        .LED(),
        .reset(camera_reset_sig),
        .PWDN(pwdn),
        .xclk(camera_clock),
        .pixelValid_verify(pixel_valid),
        .data(camera_datain),
    
    // display
//        .red(red),
//        .green(green),
//        .blue(blue),
//        .VS(vid_vsync),
//        .HS(vid_hsync),
//        .vde(vid_vde),
        
        .redHue(sw_i[0]),
        .edgeOn(sw_i[1]),
        .visualSW(sw_i[2]),
        .drawX(vid_drawX),
        .drawY(vid_drawY),
        
        .outputPixel(vid_pixel),
        .outAddress(vid_address),
        .redPixel(red_pixel)
    );
    
    vga_controller2 vga_controller2(
        .pixel_clk(clk_out25Mhz),
        .reset(reset),
        .hs(vid_hsync),
        .vs(vid_vsync),
        .active_nblank(vid_vde),
        .drawX(vid_drawX),
        .drawY(vid_drawY)
    );
    always_comb begin
        if(vid_drawX == (tarX * 40) || vid_drawY == (tarY * 40)) begin
            red = 0;
            green = 0;
            blue = 8;
        end 
        else if(vid_drawX > 600 || vid_drawY > 400) begin
            red = 0;
            green = 0;
            blue = 0;
        end else begin
            red = vid_pixel;
            green = vid_pixel;
            blue = vid_pixel;
        end
    end
    assign vid_address = vid_drawX + vid_drawY * 600;
    
    vga_to_hdmi vga_to_hdmi ( //instantiate VGA-HDMI IP here //change
        //Clocking and Reset
        .pix_clk(clk_out25Mhz),
        .pix_clkx5(clk_out125Mhz),
        .pix_clk_locked(clk_locked),
        .rst(reset),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(vid_hsync),
        .vsync(vid_vsync),
        .vde(vid_vde),
        
        //aux Data (unused)     
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
    
    target target(
        .clk(clk_out25Mhz),
        .drawX(vid_drawX),
        .drawY(vid_drawY),
        .pixelin(vid_pixel),
        .targetX(tarX),
        .targetY(tarY),
        .vsync(vid_vsync)
    );
    
       
endmodule