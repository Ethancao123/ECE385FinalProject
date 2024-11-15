vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/encode.v" \
"../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/serdes_10_to_1.v" \
"../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/srldelay.v" \
"../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/hdl/hdmi_tx_v1_0.v" \
"../../../../vivadoproject.gen/sources_1/ip/vga_to_hdmi/sim/vga_to_hdmi.v" \

vlog -work xil_defaultlib \
"glbl.v"

