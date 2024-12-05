//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Thu Dec  5 03:07:42 2024
//Host        : DESKTOP-JA1U62V running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk_100MHz,
    gpio_in,
    gpio_out,
    reset_rtl_0);
  input clk_100MHz;
  input [31:0]gpio_in;
  output [31:0]gpio_out;
  input reset_rtl_0;

  wire clk_100MHz;
  wire [31:0]gpio_in;
  wire [31:0]gpio_out;
  wire reset_rtl_0;

  design_1 design_1_i
       (.clk_100MHz(clk_100MHz),
        .gpio_in(gpio_in),
        .gpio_out(gpio_out),
        .reset_rtl_0(reset_rtl_0));
endmodule
