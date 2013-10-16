--------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Andrew Hood
--
-- Create Date:    08/24/2006
-- Design Name:    
-- Module Name:    lineDelay
-- Project Name:   Portable Camera System
-- Target Device:  Virtex-4
-- Tool versions:  
-- Description:    Programmable line delay
--						 Incoming signal is delayed by a number of clk
--						 cycles equal to delayCnt before being asserted
--					    on the output port
--
-- Dependencies:   edgeDetect.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all ;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lineDelay is
    port(
        clk       : in   std_logic;
        rst       : in   std_logic;
        I         : in   std_logic;
        delayCnt  : in   std_logic_vector(7 DOWNTO 0);
        O         : out  std_logic
    );
end lineDelay;
        
architecture behavioral of lineDelay is

component edgeDetect is
    port (
        clk          :    in std_logic;
        rst          :    in std_logic;
        strobe       :    in std_logic;
        E            :    out std_logic
    );
end component;

signal edge          :    std_logic;
signal cnt           :    std_logic_vector(7 DOWNTO 0);
signal cntDone       :    std_logic;
signal cntStarted    :    std_logic;
signal O_next        :    std_logic;
signal O_i           :    std_logic;

begin

O <= O_i;
   
-- PROGRAMMABLE DELAY --
PGMD : process(edge, cntDone)
   begin 
      
      O_next <= O_i;
      
      if (cntDone = '1') then
           O_next <= I;
           cntStarted <= '0';
      elsif (rising_edge(edge)) then
           cntStarted <= '1';
      end if;
end process;
       
PGMDCnt0 : process(cntStarted, clk)
   begin
       
       if(rising_edge(clk)) then
           if(cntStarted = '1') then
               cntDone <= '0';
               cnt <= cnt + '1';
           else
               cntDone <= '0';
               cnt <= (others => '0');
           end if;
			 if (cnt > delayCnt) then
				  cntDone <= '1';
			 else
				  cntDone <= '0';
			 end if;
       end if;

end process;

-- registered output for O --
regOut : process(rst, clk)
   begin
       if (rst = '1') then
           O_i <= '0';
       elsif (rising_edge(clk)) then
           O_i <= O_next;
       end if;
end process;
       
edgeDet0 : edgeDetect
         port map (clk => clk,
                   rst => rst,
                   strobe => I,
                   E => edge
          );    


end behavioral;
