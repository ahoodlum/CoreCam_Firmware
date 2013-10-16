-- This testbench was automatically generated


-- Filename          : tb_tmp.vhd
-- Modelname         : TB_DATAROM
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

entity TB_DATAROM is
end TB_DATAROM;

architecture BEH of TB_DATAROM is

   component DATAROM
      port(CLK    : in std_logic ;
           ADDR   : in std_logic_vector ( 7 DOWNTO 0 );
           DOUT   : out std_logic_vector ( 31 DOWNTO 0 ) );

   end component;


   constant PERIOD : time := 10 ns;

   signal W_CLK    : std_logic  := '0';
   signal W_ADDR   : std_logic_vector ( 7 DOWNTO 0 );
   signal W_DOUT   : std_logic_vector ( 31 DOWNTO 0 ) ;

begin

   DUT : DATAROM
      port map(CLK    => W_CLK,
               ADDR   => W_ADDR,
               DOUT   => W_DOUT);

   W_CLK <= not W_CLK after PERIOD/2;

   STIMULI : process
   begin
      W_ADDR   <= (others => '0');

      wait for PERIOD;
      W_ADDR <= x"01";
      wait for PERIOD;
      W_ADDR <= x"02";
      wait for PERIOD;
      W_ADDR <= x"03";
      wait for PERIOD;
      W_ADDR <= x"04";
      wait;
   end process STIMULI;

end BEH;

configuration CFG_TB_DATAROM of TB_DATAROM is
   for BEH
   end for;
end CFG_TB_DATAROM;