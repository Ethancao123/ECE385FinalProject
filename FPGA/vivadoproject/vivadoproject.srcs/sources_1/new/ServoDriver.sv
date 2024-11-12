module servo_driver (
    input logic clk_180MHz,
    input logic reset,
    input logic [7:0] angle,
    output logic PWM
);

    logic [31:0] count=0;
    logic [31:0] countcutoff;
    logic [31:0] offset;
    logic overflow;
    
    always_comb begin
        offset = 0; //180
        overflow = count >= 3600000;
        countcutoff = offset + angle*2000+180000;
    end
    
//    logic [15:0] clk_count = 0;
//    assign clk_180kHz = clk_count > 500;
//    always_ff @ (posedge clk_180MHz)
//    begin
//        if(reset) begin
//            clk_count <= 0;
//        end else begin
//            clk_count <= clk_count + 1;
//        end
//        if(clk_count >= 1000) begin
//            clk_count <= 0;
//        end
//    end
    
    always_ff @ (posedge clk_180MHz)
    begin
        if(reset || overflow) begin
            count <= 0;
            PWM <= 0;
        end else begin
            count <= count + 1;
            if(count > countcutoff) begin
                PWM <= 0;
            end else begin
                PWM <= 1;
            end
        end
    end
endmodule
