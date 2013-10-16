lappend auto_path "C:/lscc/diamond/2.0/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {sim_par}
set ::bali::simulation::Para(PROJECTPATH) {C:/lscc/diamond/2.0/examples/timing_controller}
set ::bali::simulation::Para(FILELIST) {"C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.vho" "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/timing_controller_TB.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"" "" "" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "none" "none" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {TESTBENCH_FOR_timing_controller_top}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {/UUT}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.sdf}
::bali::simulation::ActiveHDL_Run
