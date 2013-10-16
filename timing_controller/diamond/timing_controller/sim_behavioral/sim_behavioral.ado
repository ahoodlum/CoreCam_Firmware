setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/lscc/diamond/2.0/examples/timing_controller/sim_behavioral/sim_behavioral.adf"]} { 
	design create sim_behavioral "C:/lscc/diamond/2.0/examples/timing_controller"
  set newDesign 1
}
design open "C:/lscc/diamond/2.0/examples/timing_controller/sim_behavioral"
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
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/led_blinker.vhd"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/instrom.vhd"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/datarom.vhd"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/ucontroller.vhd"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/reset_generator_v0p1.vhd"
addfile "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/timing_controller_top.vhd"
addfile "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd"
vlib "C:/lscc/diamond/2.0/examples/timing_controller/sim_behavioral/work"
set worklib work
adel -all
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/led_blinker.vhd"
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/instrom.vhd"
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/datarom.vhd"
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/ucontroller.vhd"
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/reset_generator_v0p1.vhd"
vcom -work work "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/timing_controller_top.vhd"
vcom "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd"
entity TESTBENCH_FOR_pat_gen_top
