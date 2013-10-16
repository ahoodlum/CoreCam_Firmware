setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/lscc/diamond/2.0/examples/timing_controller/post_par/post_par.adf"]} { 
	design create post_par "C:/lscc/diamond/2.0/examples/timing_controller"
  set newDesign 1
}
design open "C:/lscc/diamond/2.0/examples/timing_controller/post_par"
cd "C:/lscc/diamond/2.0/examples/timing_controller"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.vho"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/uController_tb.vhd"
addfile -sdf "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.sdf"
	vlib "C:/lscc/diamond/2.0/examples/timing_controller/post_par/work"
set worklib work
adel -all
vcom "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.vho"
vcom "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/uController_tb.vhd"
entity CFG_TB_UCONTROLROICCLK
designsdffile "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.sdf" /CFG_TB_UCONTROLROICCLK/  -sdfmax -load yes
