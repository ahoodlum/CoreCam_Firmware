setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller/sim_behavioral/sim_behavioral.adf"]} { 
	design create sim_behavioral "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller"
  set newDesign 1
}
design open "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller/sim_behavioral"
cd "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/instrom.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/datarom.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/ucontroller.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/wb_to_timing_controller.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/led_blinker.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/dual_edge_counter.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/edgedetect.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/video_generator.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/reset_generator_v0p1.vhd"
addfile "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/timing_controller_top.vhd"
addfile "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/ucontrolroicclk_TB.vhd"
vlib "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller/sim_behavioral/work"
set worklib work
adel -all
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/instrom.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/datarom.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/ucontroller.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/wb_to_timing_controller.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/led_blinker.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/dual_edge_counter.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/edgedetect.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/video_generator.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/reset_generator_v0p1.vhd"
vcom -dbg -work work "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/timing_controller_top.vhd"
vcom -dbg "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/ucontrolroicclk_TB.vhd"
entity TESTBENCH_FOR_ucontrolroicclk
vsim +access +r TESTBENCH_FOR_ucontrolroicclk   -PL pmi_work -L ovi_machxo2
add wave *
