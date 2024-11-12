module ServoTestbench();

    logic clk = 1'b0;
    logic reset = 1'b0;
    logic out = 1'b0;
    logic [7:0] angle = 8'b0;
    
    servo_driver driver1(
        .clk_180MHz(clk),
        .reset(reset),
        .angle(angle),
        .PWM(out)
    );
    initial begin: CLOCK_INITIALIZATION
	   clk = 1'b1;
    end 
       
    always begin : CLOCK_GENERATION
        #5 clk = ~clk;
    end
    
        initial begin: TEST_VECTORS
        reset = 0; //reset IP
        repeat (4) @(posedge clk);
        
        angle = 90;
        
        repeat (100000000) @(posedge clk);
        
        angle = 0;
        repeat (100000000) @(posedge clk);
        angle = 180;
        repeat (100000000) @(posedge clk);
		$finish();
	end
endmodule