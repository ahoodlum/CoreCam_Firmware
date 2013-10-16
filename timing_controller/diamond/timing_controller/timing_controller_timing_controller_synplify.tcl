#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology MACHXO2
set_option -part LCMXO2_7000HE
set_option -package TG144C
set_option -speed_grade -4

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency 1
set_option -maxfan 1000
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe true
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup false
set_option -frequency 1
set_option -default_enum_encoding default

#simulation options


#timing analysis options



#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0

#-- add_file options
set_option -include_path {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond}
add_file -verilog {C:/lscc/diamond/2.1_x64/cae_library/synthesis/verilog/machxo2.v}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/timing_controller_top.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/datarom.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/instrom.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/ucontroller.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/led_blinker.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/reset_generator_v0p1.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/video_generator.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/edgedetect.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/dual_edge_counter.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/../firmware/wb_to_timing_controller.vhd}
add_file -vhdl -lib "work" {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/firmware/linedelay.vhd}
add_file -verilog {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/msb/timing_controller/soc/timing_controller.v}

#-- top module name
set_option -top_module timing_controller_top

#-- set result format/file last
project -result_file {C:/Users/AndrewPC1/Documents/GitHub/CoreCam_Firmware/timing_controller/diamond/timing_controller/timing_controller_timing_controller.edi}

#-- error message log file
project -log_file {timing_controller_timing_controller.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run hdl_info_gen -fileorder
project -run
