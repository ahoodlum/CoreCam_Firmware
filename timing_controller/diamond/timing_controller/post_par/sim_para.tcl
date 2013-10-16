lappend auto_path "C:/lscc/diamond/2.0/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {post_par}
set ::bali::simulation::Para(PROJECTPATH) {C:/lscc/diamond/2.0/examples/timing_controller}
set ::bali::simulation::Para(FILELIST) {"C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.vho" "C:/Users/AndrewPC1/Documents/Work/fpga/pattern_generator/uController_tb.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"" "" "" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "none" "none" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {CFG_TB_UCONTROLROICCLK}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {/}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {C:/lscc/diamond/2.0/examples/timing_controller/timing_controller_timing_controller_vho.sdf}
::bali::simulation::ActiveHDL_Run
