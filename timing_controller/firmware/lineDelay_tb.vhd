-- Filename          : tb_tmp.vhd
-- Modelname         : TB_LINEDELAY
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

entity TB_LINEDELAY is
end TB_LINEDELAY;

architecture BEH of TB_LINEDELAY is

   component LINEDELAY
      port(CLK        : in std_logic ;
           RST        : in std_logic ;
           I          : in std_logic ;
           DELAYCNT   : in std_logic_vector ( 7 DOWNTO 0 );
           O          : out std_logic );

   end component;


   constant PERIOD : time := 3333 ps;

   signal W_CLK        : std_logic  := '0';
   signal W_RST        : std_logic ;
   signal W_I          : std_logic ;
   signal W_DELAYCNT   : std_logic_vector ( 7 DOWNTO 0 );
   signal W_O          : std_logic ;

begin

   DUT : LINEDELAY
      port map(CLK        => W_CLK,
               RST        => W_RST,
               I          => W_I,
               DELAYCNT   => W_DELAYCNT,
               O          => W_O);

   W_CLK <= not W_CLK after PERIOD/2;

   STIMULI : process
   begin
      W_RST        <= '0';
      W_I          <= '0';
      W_DELAYCNT   <= (others => '0');

		wait for PERIOD;
		W_RST <= '1';
		wait for PERIOD*4;
		W_RST <= '0';
		W_DELAYCNT <= "01001100";
		W_DELAYCNT <= "00000000";
		wait for PERIOD*2;
		W_I	<= '1';
		wait for PERIOD*256;
		
		W_I <= '0';
		
		wait for PERIOD*256;
		
      wait for PERIOD*1000;
      wait;
   end process STIMULI;

end BEH;

configuration CFG_TB_LINEDELAY of TB_LINEDELAY is
   for BEH
   end for;
end CFG_TB_LINEDELAY;