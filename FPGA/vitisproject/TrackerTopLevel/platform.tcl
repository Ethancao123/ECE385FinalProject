# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\ethan\Documents\GitHub\ECE385FinalProject\FPGA\vitisproject\TrackerTopLevel\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\ethan\Documents\GitHub\ECE385FinalProject\FPGA\vitisproject\TrackerTopLevel\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {TrackerTopLevel}\
-hw {C:\Users\ethan\Documents\GitHub\ECE385FinalProject\FPGA\vivadoproject\TrackerTopLevel.xsa}\
-out {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vitisproject}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {TrackerTopLevel}
platform generate -quick
platform generate
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform clean
platform generate
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform clean
platform generate
platform active {TrackerTopLevel}
platform config -updatehw {C:/Users/ethan/Documents/GitHub/ECE385FinalProject/FPGA/vivadoproject/TrackerTopLevel.xsa}
platform generate -domains 
