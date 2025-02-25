onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc "  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.vga_to_hdmi xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {vga_to_hdmi.udo}

run 1000ns

quit -force
