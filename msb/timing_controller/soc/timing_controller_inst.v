//   ==================================================================
//   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
//   ------------------------------------------------------------------
//   Copyright (c) 2006-2011 by Lattice Semiconductor Corporation
//   ------------------------------------------------------------------
//   ALL RIGHTS RESERVED
//
//   IMPORTANT: THIS FILE IS AUTO-GENERATED BY THE LATTICEMICO SYSTEM.
//
//   Permission:
//
//      Lattice Semiconductor grants permission to use this code
//      pursuant to the terms of the Lattice Semiconductor Corporation
//      Open Source License Agreement.
//
//   Disclaimer:
//
//      Lattice Semiconductor provides no warranty regarding the use or
//      functionality of this code. It is the user's responsibility to
//      verify the user�s design for consistency and functionality through
//      the use of formal verification methods.
//
//   --------------------------------------------------------------------
//
//                  Lattice Semiconductor Corporation
//                  5555 NE Moore Court
//                  Hillsboro, OR 97214
//                  U.S.A
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                         503-286-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
//   --------------------------------------------------------------------
//
//      Project:           timing_controller
//      File:              timing_controller_inst.v
//      Date:              Mon, 2 Sep 2013 07:06:07 PDT
//      Version:           2.1
//      Targeted Family:   MachXO2
//
//   =======================================================================

// Attn : This file is used for VHDL Wrapper

timing_controller_vhd timing_controller_u ( 
.clk_i(clk_i),
.reset_n(reset_n)
, .LEDPIO_OUT(LEDPIO_OUT) // [4-1:0]
, .uartSIN(uartSIN) // 
, .uartSOUT(uartSOUT) // 
, .timing_controllerclk(timing_controllerclk) // 
, .timing_controllerrst(timing_controllerrst) // 
, .timing_controllerslv_adr(timing_controllerslv_adr) // [32-1:0]
, .timing_controllerslv_master_data(timing_controllerslv_master_data) // [8-1:0]
, .timing_controllerslv_slave_data(timing_controllerslv_slave_data) // [8-1:0]
, .timing_controllerslv_strb(timing_controllerslv_strb) // 
, .timing_controllerslv_cyc(timing_controllerslv_cyc) // 
, .timing_controllerslv_ack(timing_controllerslv_ack) // 
, .timing_controllerslv_err(timing_controllerslv_err) // 
, .timing_controllerslv_rty(timing_controllerslv_rty) // 
, .timing_controllerslv_sel(timing_controllerslv_sel) // [3:0] 
, .timing_controllerslv_we(timing_controllerslv_we) // 
, .timing_controllerslv_bte(timing_controllerslv_bte) // [1:0] 
, .timing_controllerslv_cti(timing_controllerslv_cti) // [2:0] 
, .timing_controllerslv_lock(timing_controllerslv_lock) // 
, .timing_controllerintr_active_high(timing_controllerintr_active_high) // 
);