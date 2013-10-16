setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/lscc/diamond/2.0/examples/timing_controller/sim_map/sim_map.adf"]} { 
	design create sim_map "C:/lscc/diamond/2.0/examples/timing_controller"
  set newDesign 1
}
design open "C:/lscc/diamond/2.0/examples/timing_controller/sim_map"
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
addfile "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_mapvho.vho"
addfile "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd"
addfile -sdf "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_mapvho.sdf"
	vlib "C:/lscc/diamond/2.0/examples/timing_controller/sim_map/work"
set worklib work
adel -all
vcom "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_mapvho.vho"
vcom "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd"
entity TESTBENCH_FOR_timing_controller_top
designsdffile "C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_mapvho.sdf" /TESTBENCH_FOR_timing_controller_top/  -sdfmax -load yes
