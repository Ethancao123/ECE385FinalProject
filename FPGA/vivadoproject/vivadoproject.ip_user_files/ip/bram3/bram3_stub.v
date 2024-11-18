// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sun Nov 17 20:03:29 2024
// Host        : DESKTOP-JA1U62V running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/vivadoproject.gen/sources_1/ip/bram3/bram3_stub.v
// Design      : bram3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *)
module bram3(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[16:0],dina[3:0],douta[3:0],clkb,enb,web[0:0],addrb[16:0],dinb[3:0],doutb[3:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [16:0]addra;
  input [3:0]dina;
  output [3:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [16:0]addrb;
  input [3:0]dinb;
  output [3:0]doutb;
endmodule
