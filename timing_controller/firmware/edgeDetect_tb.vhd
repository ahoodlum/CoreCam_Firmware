-- This testbench was automatically generated


-- Filename          : tb_tmp.vhd
-- Modelname         : TB_EDGE_DETECTOR
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
-- 1.0      | root | 24.08.2006 | inital version


library IEEE;
use IEEE.std_logic_1164.all;

entity TB_EDGE_DETECTOR is
end TB_EDGE_DETECTOR;

architecture BEH of TB_EDGE_DETECTOR is

   component EDGE_DETECTOR
      port(CLK      : in std_logic ;
           RST      : in std_logic ;
           STROBE   : in std_logic ;
           E        : out std_logic );

   end component;


   constant PERIOD : time := 10 ns;

   signal W_CLK      : std_logic  := '0';
   signal W_RST      : std_logic ;
   signal W_STROBE   : std_logic ;
   signal W_E        : std_logic ;

begin

   DUT : EDGE_DETECTOR
      port map(CLK      => W_CLK,
               RST      => W_RST,
               STROBE   => W_STROBE,
               E        => W_E);

   W_CLK <= not W_CLK after PERIOD/2;

   STIMULI : process
   begin
      W_RST      <= '0';
      W_STROBE   <= '0';

      wait for PERIOD;
      
      W_RST <= '1';
      
      wait for PERIOD*2;
      W_RST <= '0';
      wait for PERIOD*10;
      W_STROBE <= '1';
      wait for PERIOD*7;
      W_STROBE <= '0';
      wait for PERIOD*10;
      
      wait;
   end process STIMULI;

end BEH;

configuration CFG_TB_EDGE_DETECTOR of TB_EDGE_DETECTOR is
   for BEH
   end for;
end CFG_TB_EDGE_DETECTOR;