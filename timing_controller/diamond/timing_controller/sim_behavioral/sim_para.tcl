lappend auto_path "C:/lscc/diamond/2.0/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {sim_behavioral}
set ::bali::simulation::Para(PROJECTPATH) {C:/lscc/diamond/2.0/examples/timing_controller}
set ::bali::simulation::Para(FILELIST) {"C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/led_blinker.vhd" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/instrom.vhd" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/datarom.vhd" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/ucontroller.vhd" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/reset_generator_v0p1.vhd" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/timing_controller_top.vhd" "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "none" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {TESTBENCH_FOR_pat_gen_top}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
::bali::simulation::ActiveHDL_Run
