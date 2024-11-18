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
