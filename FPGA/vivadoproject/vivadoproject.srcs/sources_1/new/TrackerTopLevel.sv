module TrackerTopLevel (
    output logic Servo1PWM,
    output logic Servo2PWM,
    input logic [15:0] sw_i,
    input logic clk,
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
    logic clk_out25MHz;
    logic clk_out125MHz;
    logic clk_out180MHz;
    logic clk_locked;
    logic start_config;
    logic config_done;
    assign reset = reset_rtl_0;
    assign camera_clock = clk_out25MHz;
    logic [15:0] camera_to_vram;
    
    logic [3:0] red;
    logic [3:0] green;
    logic [3:0] blue;
    logic pixel_valid;
    logic vid_vsync;
    logic vid_hsync;
    logic vid_vde;
    logic [9:0] vid_drawX, vid_drawY;
    
    logic [16:0] cam_vramb_addr;
    logic [8:0] cam_vramb_data;
    
    servo_driver driver1(
        .clk_180MHz(clk_out180Mhz),
        .reset(reset),
        .angle(sw_i[7:0]),
        .PWM(Servo1PWM)
    );
    
    servo_driver driver2(
        .clk_180MHz(clk_out180Mhz),
        .reset(reset),
        .angle(sw_i[15:8]),
        .PWM(Servo2PWM)
    );
    
    clk_wiz_1 clk_wiz_1(
        .reset(reset),
        .clk_in1(clk),
        .clk_out1(clk_out125MHz),
        .clk_out2(clk_out180Mhz),
        .clk_out3(clk_out25MHz),
        .locked(clk_locked)
    );
    
//    camera_read camera(
//        .p_clock(camera_pixel_clock),
//        .vsync(camera_vsync),
//        .href(camera_href),
//        .p_data(camera_datain),
//        .pixel_data(camera_to_vram),
//        .pixel_valid(pixel_valid),
//        .frame_done(frame_done)
//    );
    
//    camera_configure camera_config(
//        .clk(clk_out25MHz),
//        .start(start_config),
//        .sioc(i2c_scl),
//        .siod(i2c_sda),
//        .done(config_done)
//    );
    
//always_ff @ (posedge clk_out25MHz) begin
//    if(~config_done) begin
//        start_config <= 1;
//    end else begin
//        start_config <= 0;
//    end
//end

    topModule camera_top (
        .clkMain(clk),
        .clk25_reg(clk_out25MHz),
        .resetButton(reset),
        .pclk(camera_pixel_clock),
        .href(camera_href),
        .sioc(i2c_scl),
        .siod(i2c_sda),
        .vsync(camera_vsync), 
    
        .LED(),
        .reset(camera_reset_sig),
        .PWDN(pwdn),
        .xclk(clk_out25MHz),
        .pixelValid_verify(pixel_valid),
        .data(camera_datain),
    
    // display
        .red(red),
        .green(green),
        .blue(blue),
        .VS(vid_vsync),
        .HS(vid_hsync)
    );
    vga_to_hdmi vga_to_hdmi ( //instantiate VGA-HDMI IP here //change
        //Clocking and Reset
        .pix_clk(clk_out25MHz),
        .pix_clkx5(clk_out125MHz),
        .pix_clk_locked(clk_locked),
        .rst(reset),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(vid_hsync),
        .vsync(vid_vsync),
        .vde(1'b1),
        
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
    
//    vga_controller vga (
//        .pixel_clk(clk_out25MHz),
//        .reset(reset),
//        .hs(vid_hsync),
//        .vs(vid_vsync),
//        .active_nblank(vid_vde),
////        .sync(sync),
//        .drawX(vid_drawX),
//        .drawY(vid_drawY)
//    );
    
//    display_mapper display_mapper (
//        .drawX(vid_drawX),
//        .drawY(vid_drawY),
//        .red(red),
//        .green(green),
//        .blue(blue),
//        .vram_addr(cam_vramb_addr),
//        .vram_data(cam_vramb_data)
//    );
    
//    logic [16:0] pixel_count = 0;
//    always_ff @(posedge camera_pixel_clock) begin
//        if(camera_vsync & ~reset) begin
//            pixel_count = pixel_count + 1;
//        end else begin
//            pixel_count = 0;
//        end
//    end
//    logic [8:0] camera_to_vram_short;
//    assign camera_to_vram_short = {camera_to_vram[15:13], camera_to_vram[10:8], camera_to_vram[4:1]};
//    camera_downsize downsize (
//        .vsync(camera_vsync),
//        .hsync(camera_href),
//        .pixel_data(camera_to_vram),
//        .pixel_clock(camera_pixel_clock),
//        .reset(reset),
//        .pixel_valid(),
//        .frame_done(),
        
//        .we(),
//        .vram_addr(),
//        .vram_data()
//    );
    
    
//    blk_mem_gen_0 camera_vram (
//        .clka(camera_pixel_clock),
//        .clkb(clk_out25MHz),

//        // Port A
//        .ena (1'b1),
//        .wea (pixel_valid & camera_href & camera_vsync),
//        .addra (pixel_count),
//        .dina (camera_to_vram_short),
//        .douta (),

//        // Port B
//        .enb (1'b1),
//        .addrb (cam_vramb_addr),
//        .doutb (cam_vramb_data)
//    );
    
    
       
endmodule