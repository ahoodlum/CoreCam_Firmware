SetActiveLib -work
comp -include "$dsn\src\wb_to_timing_controller.vhd" 
comp -include "C:\Users\AndrewPC1\Documents\Work\fpga\pattern_generator\wb_to_timing_controller_TB.vhd" 
asim +access +r TESTBENCH_FOR_wb_to_timing_controller 
wave 
wave -noreg wb_clk_i
wave -noreg wb_rst_i
wave -noreg wb_dat_i
wave -noreg wb_addr_i
wave -noreg wb_cyc_i
wave -noreg wb_stb_i
wave -noreg wb_we_i
wave -noreg wb_dat_o
wave -noreg wb_ack_o
wave -noreg wb_int_o
wave -noreg reg_0
wave -noreg reg_1
wave -noreg reg_2
wave -noreg reg_3
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "C:\Users\AndrewPC1\Documents\Work\fpga\pattern_generator\wb_to_timing_controller_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_wb_to_timing_controller 
