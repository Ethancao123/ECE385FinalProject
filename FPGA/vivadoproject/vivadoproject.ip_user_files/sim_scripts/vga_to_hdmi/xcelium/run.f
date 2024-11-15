-makelib xcelium_lib/xpm -sv \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/encode.v" \
  "../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/serdes_10_to_1.v" \
  "../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/srldelay.v" \
  "../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/hdmi_tx_v1_0.v" \
  "../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/sim/vga_to_hdmi.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

