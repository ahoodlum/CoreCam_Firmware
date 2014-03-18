lappend auto_path "C:/lscc/diamond/2.2_x64/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {sim_behavioral}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller}
set ::bali::simulation::Para(FILELIST) {"C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/instrom.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/datarom.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/ucontroller.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/wb_to_timing_controller.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/led_blinker.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/dual_edge_counter.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/edgedetect.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/video_generator.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/reset_generator_v0p1.vhd" "C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/timing_controller_top.vhd" "C:/my_designs/pattern_generator/pattern_generator_v0p1/src/TestBench/ucontrolroicclk_TB.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "none" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {TESTBENCH_FOR_ucontrolroicclk}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {0}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ActiveHDL_Run
