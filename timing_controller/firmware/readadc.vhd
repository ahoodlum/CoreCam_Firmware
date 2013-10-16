--------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Andrew Hood
--
-- Create Date:    07/25/2006
-- Design Name:    
-- Module Name:    readADC.vhd
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:   Reads the output of the 14-bit ADC on the falling and rising edges of the ADC
--                clock.  This file will need to be changed when the final ADC clock is defined.
--                Right now ADC read signals are being generated on ADC1-4 (roicCLK(18:21)).  We
--                will use just one of these ADC1 and read on the rising (channel A) and falling
--                (channel B) of this clock.
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity readADC is
    Port ( ADCstrb : in std_logic;
           ADCinput : in std_logic_vector(13 DOWNTO 0);
			  ADCdata0 : out std_logic_vector(13 DOWNTO 0);
			  ADCdata1 : out std_logic_vector(13 DOWNTO 0)
			  );
end readADC;

architecture Behavioral of readADC is
    
    begin
        
        main_rising : process(ADCstrb)
        
        begin
            
            if rising_edge(ADCstrb) then
                ADCdata0 <= ADCinput;
            end if;
        
       end process;

		  main_falling : process(ADCstrb)
        
        begin
            
            if falling_edge(ADCstrb) then
                ADCdata1 <= ADCinput;
            end if;
        
       end process; 

end Behavioral;