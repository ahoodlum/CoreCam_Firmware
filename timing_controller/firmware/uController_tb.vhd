-- This testbench was automatically generated


-- Filename          : tb_tmp.vhd
-- Modelname         : TB_UCONTROLROICCLK
-- Title             :
-- Purpose           :
-- Author(s)         : root
-- Comment           :
-- Assumptions       :
-- Limitations       :
-- Known errors      :
-- Specification ref :
-- ------------------------------------------------------------------------
-- Modification history:
-- ------------------------------------------------------------------------
-- Version  | Author | Date       | Changes made
-- ------------------------------------------------------------------------
-- 1.0      | root | 17.07.2006 | inital version


library IEEE;
use IEEE.std_logic_1164.all;

entity TB_UCONTROLROICCLK is
end TB_UCONTROLROICCLK;

architecture BEH of TB_UCONTROLROICCLK is

      component UCONTROLROICCLK
      port(UCCLK       : in std_logic ;
           DELAYCLK    : in std_logic ;
           RST         : in std_logic ;
           MCLK        : out std_logic ;
           ROICFS      : out std_logic ;
           ROICLS      : out std_logic ;
           FS          : out std_logic ;
           LS          : out std_logic ;
           SW_LOAD     : out std_logic ;
           ADC2XCLK    : out std_logic ;
           ADCCLK0     : out std_logic );

   end component;


   constant uCPERIOD : time := 80 ns;
   constant delayPERIOD : time := 3 ns;
   
   signal W_UCCLK      : std_logic := '0';
   signal W_DELAYCLK   : std_logic := '0';
   signal W_RST         : std_logic ;
   signal W_MCLK        : std_logic ;
   signal W_ROICFS      : std_logic ;
   signal W_ROICLS      : std_logic ;
   signal W_FS          : std_logic ;
   signal W_LS          : std_logic ;
   signal W_SW_LOAD     : std_logic ;
   signal W_ADC2XCLK    : std_logic ;
   signal W_ADCCLK0     : std_logic ;
  

begin

   DUT : UCONTROLROICCLK
      port map(UCCLK      => W_UCCLK,
               DELAYCLK   => W_DELAYCLK,
               RST         => W_RST,
               MCLK        => W_MCLK,
               ROICFS      => W_ROICFS,
               ROICLS      => W_ROICLS,
               FS          => W_FS,
               LS          => W_LS,
               SW_LOAD     => W_SW_LOAD,
               ADC2XCLK    => W_ADC2XCLK,
               ADCCLK0     => W_ADCCLK0);

   W_UCCLK <= not W_UCCLK after uCPERIOD/2;
   W_DELAYCLK <= not W_DELAYCLK after delayPERIOD/2;

   STIMULI : process
   begin
   
   		W_RST <= '0';
   		wait for uCPERIOD;
      W_RST      <= '1';

      wait for uCPERIOD;
      
      W_RST <= '0';
      
      wait for uCPERIOD * 10000;
      wait;
   end process STIMULI;

end BEH;

configuration CFG_TB_UCONTROLROICCLK of TB_UCONTROLROICCLK is
   for BEH
   end for;
end CFG_TB_UCONTROLROICCLK;