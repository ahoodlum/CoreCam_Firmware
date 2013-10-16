library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity timing_controller_vhd is
port(
clk_i   : in std_logic
; reset_n : in std_logic
; LEDPIO_OUT : out std_logic_vector(3 downto 0)
; uartSIN : in std_logic
; uartSOUT : out std_logic
; timing_controllerclk : out std_logic
; timing_controllerrst : out std_logic
; timing_controllerslv_adr : out std_logic_vector(31 downto 0)
; timing_controllerslv_master_data : out std_logic_vector(7 downto 0)
; timing_controllerslv_slave_data : in std_logic_vector(7 downto 0)
; timing_controllerslv_strb : out std_logic
; timing_controllerslv_cyc : out std_logic
; timing_controllerslv_ack : in std_logic
; timing_controllerslv_err : in std_logic
; timing_controllerslv_rty : in std_logic
; timing_controllerslv_sel : out std_logic_vector(3 downto 0)
; timing_controllerslv_we : out std_logic
; timing_controllerslv_bte : out std_logic_vector(1 downto 0)
; timing_controllerslv_cti : out std_logic_vector(2 downto 0)
; timing_controllerslv_lock : out std_logic
; timing_controllerintr_active_high : in std_logic
);
end timing_controller_vhd;

architecture timing_controller_vhd_a of timing_controller_vhd is

component timing_controller
   port(
      clk_i   : in std_logic
      ; reset_n : in std_logic
      ; LEDPIO_OUT : out std_logic_vector(3 downto 0)
      ; uartSIN : in std_logic
      ; uartSOUT : out std_logic
      ; timing_controllerclk : out std_logic
      ; timing_controllerrst : out std_logic
      ; timing_controllerslv_adr : out std_logic_vector(31 downto 0)
      ; timing_controllerslv_master_data : out std_logic_vector(7 downto 0)
      ; timing_controllerslv_slave_data : in std_logic_vector(7 downto 0)
      ; timing_controllerslv_strb : out std_logic
      ; timing_controllerslv_cyc : out std_logic
      ; timing_controllerslv_ack : in std_logic
      ; timing_controllerslv_err : in std_logic
      ; timing_controllerslv_rty : in std_logic
      ; timing_controllerslv_sel : out std_logic_vector(3 downto 0)
      ; timing_controllerslv_we : out std_logic
      ; timing_controllerslv_bte : out std_logic_vector(1 downto 0)
      ; timing_controllerslv_cti : out std_logic_vector(2 downto 0)
      ; timing_controllerslv_lock : out std_logic
      ; timing_controllerintr_active_high : in std_logic
      );
   end component;

begin

lm8_inst : timing_controller
port map (
   clk_i  => clk_i
   ,reset_n  => reset_n
   ,LEDPIO_OUT  => LEDPIO_OUT
   ,uartSIN  => uartSIN
   ,uartSOUT  => uartSOUT
   ,timing_controllerclk  => timing_controllerclk
   ,timing_controllerrst  => timing_controllerrst
   ,timing_controllerslv_adr  => timing_controllerslv_adr
   ,timing_controllerslv_master_data  => timing_controllerslv_master_data
   ,timing_controllerslv_slave_data  => timing_controllerslv_slave_data
   ,timing_controllerslv_strb  => timing_controllerslv_strb
   ,timing_controllerslv_cyc  => timing_controllerslv_cyc
   ,timing_controllerslv_ack  => timing_controllerslv_ack
   ,timing_controllerslv_err  => timing_controllerslv_err
   ,timing_controllerslv_rty  => timing_controllerslv_rty
   ,timing_controllerslv_sel  => timing_controllerslv_sel
   ,timing_controllerslv_we  => timing_controllerslv_we
   ,timing_controllerslv_bte  => timing_controllerslv_bte
   ,timing_controllerslv_cti  => timing_controllerslv_cti
   ,timing_controllerslv_lock  => timing_controllerslv_lock
   ,timing_controllerintr_active_high  => timing_controllerintr_active_high
   );

end timing_controller_vhd_a;

