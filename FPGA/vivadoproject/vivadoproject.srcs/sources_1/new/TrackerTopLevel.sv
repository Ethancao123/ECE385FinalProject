module TrackerTopLevel (
    output logic Servo1PWM,
    output logic Servo2PWM,
    input logic [15:0] sw_i,
    input logic clk,
    input logic reset_rtl_0
);
    logic clk_out100MHz;
    logic clk_out180MHz;
    logic reset;
    assign reest = ~reset_rtl_0;
    
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
        .clk_out1(clk_out100MHz),
        .clk_out2(clk_out180Mhz)
    );
endmodule