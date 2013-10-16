-- Filename          : tb_tmp.vhd
-- Modelname         : TB_CLK_DIV
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
-- 1.0      | root | 25.08.2006 | inital version


library IEEE;
use IEEE.std_logic_1164.all;

entity TB_CLKDIV is
end TB_CLKDIV;

architecture BEH of TB_CLKDIV is

   component CLKDIV
      port(ICLK   : in std_logic ;
           RST    : in std_logic ;
           DIV    : in std_logic_vector ( 2 DOWNTO 0 );
           OCLK   : out std_logic );

   end component;


   constant PERIOD : time := 3.333 ns;

   signal W_ICLK   : std_logic := '0';
   signal W_RST    : std_logic ;
   signal W_DIV    : std_logic_vector ( 2 DOWNTO 0 );
   signal W_OCLK   : std_logic ;

begin

   DUT : CLKDIV
      port map(ICLK   => W_ICLK,
               RST    => W_RST,
               DIV    => W_DIV,
               OCLK   => W_OCLK);

   W_ICLK <= not W_ICLK after PERIOD/2;

   STIMULI : process
   begin
      
      
      W_RST    <= '0';
      W_DIV    <= "001";

      wait for PERIOD;
      W_RST    <= '1';
      
      wait for PERIOD;
      W_RST    <= '0';
      
      wait for PERIOD*20;
      W_DIV    <= "010";
      wait for PERIOD*20;
      W_DIV    <= "011";
      wait for PERIOD*20;
      W_DIV    <= "100";
      wait for PERIOD*20;
      
      wait;
   end process STIMULI;

end BEH;

configuration CFG_TB_CLKDIV of TB_CLKDIV is
   for BEH
   end for;
end CFG_TB_CLKDIV;