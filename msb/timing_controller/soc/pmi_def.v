// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2011 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Black Box definition for PMI Blocks
// fpga\verilog\pkg\versclibs\data\pmi\pmi_def.v 1.37 15-FEB-2013 12:19:58 PYAO

module pmi_distributed_dpram 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_dpram")

    (
    input [(pmi_addr_width-1):0] WrAddress,
    input [(pmi_data_width-1):0] Data,
    input WrClock,
    input WE,
    input WrClockEn,
    input [(pmi_addr_width-1):0] RdAddress,
    input RdClock,
    input RdClockEn,
    input Reset,
    output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

endmodule // pmi_distributed_dpram

module pmi_distributed_spram 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_spram")

    (
     input [(pmi_addr_width-1):0] Address,
     input [(pmi_data_width-1):0] Data,
     input Clock,
     input ClockEn,
     input WE,
     input Reset,
     output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

endmodule // pmi_distributed_spram

module pmi_addsub #(parameter pmi_data_width = 8,
		    parameter pmi_result_width = 8,
		    parameter pmi_sign = "off",
		    parameter pmi_family = "EC",
		    parameter module_type = "pmi_addsub"
		    )
  
  (
   input [pmi_data_width-1:0] DataA,
   input [pmi_data_width-1:0] DataB,
   input Cin,
   input Add_Sub,
   output [pmi_data_width-1:0] Result,
   output Cout,
   output Overflow)/*synthesis syn_black_box */;
endmodule // pmi_addsub

module pmi_ram_dp
  #(parameter pmi_wr_addr_depth = 512,
    parameter pmi_wr_addr_width = 9,
    parameter pmi_wr_data_width = 18,
    parameter pmi_rd_addr_depth = 512,
    parameter pmi_rd_addr_width = 9,
    parameter pmi_rd_data_width = 18,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_optimization = "speed",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_ram_dp")
    
    (input [(pmi_wr_data_width-1):0] Data,
     input [(pmi_wr_addr_width-1):0] WrAddress,
     input [(pmi_rd_addr_width-1):0] RdAddress,
     input  WrClock,
     input  RdClock,
     input  WrClockEn,
     input  RdClockEn,
     input  WE,
     input  Reset,
     output [(pmi_rd_data_width-1):0]  Q) /*synthesis syn_black_box*/;

endmodule // pmi_ram_dp

module pmi_ram_dq
  #(parameter pmi_addr_depth = 512,
    parameter pmi_addr_width = 9,
    parameter pmi_data_width = 18,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_optimization = "speed",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_write_mode = "normal",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_ram_dq")
    
    (input [(pmi_data_width-1):0]	Data,
     input [(pmi_addr_width-1):0] Address,
     input  Clock,
     input  ClockEn,
     input  WE,
     input  Reset,
     output [(pmi_data_width-1):0]  Q)/*synthesis syn_black_box*/;
   
endmodule // pmi_ram_dq

module pmi_rom
  #(parameter pmi_addr_depth = 512,
    parameter pmi_addr_width = 9,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_optimization = "speed",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_rom")

    (input [(pmi_addr_width-1):0]	Address,
     input OutClock,
     input OutClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

endmodule // pmi_rom

module pmi_fifo_dc #(
		     parameter pmi_data_width_w = 18,
		     parameter pmi_data_width_r = 18,
		     parameter pmi_data_depth_w = 256,
		     parameter pmi_data_depth_r = 256,
		     parameter pmi_full_flag = 256,
		     parameter pmi_empty_flag = 0,
		     parameter pmi_almost_full_flag = 252,
		     parameter pmi_almost_empty_flag = 4,
		     parameter pmi_regmode = "reg",
		     parameter pmi_resetmode = "async",
		     parameter pmi_family = "EC" ,
		     parameter module_type = "pmi_fifo_dc",
			  parameter pmi_implementation = "EBR"
		     )

  (input  [pmi_data_width_w-1:0] Data,
   input WrClock,
   input RdClock,
   input WrEn,
   input RdEn,
   input Reset,
   input RPReset,
   output [pmi_data_width_r-1:0] Q,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

endmodule // pmi_fifo_dc

module pmi_fifo #(
		     parameter pmi_data_width = 8,
		     parameter pmi_data_depth = 256,
		     parameter pmi_full_flag = 256,
		     parameter pmi_empty_flag = 0,
		     parameter pmi_almost_full_flag = 252,
		     parameter pmi_almost_empty_flag = 4,
		     parameter pmi_regmode = "reg",
		     parameter pmi_family = "EC" ,
		     parameter module_type = "pmi_fifo",
			  parameter pmi_implementation = "EBR")

  (input  [pmi_data_width-1:0] Data,
   input Clock,
   input WrEn,
   input RdEn,
   input Reset,
   output [pmi_data_width-1:0] Q,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

endmodule // pmi_fifo

