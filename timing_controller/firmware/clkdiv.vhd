
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


--div_clk_by : the number you want to divide the clock by
--num_bits : the number of bits required to hold the size of the
--constant div_clk_by

entity clkDiv is
--generic (div_clk_by: positive :=6;
port (
		Iclk					: in std_logic;			-- input clock
		rst					: in std_logic;   -- output clock
		div					: in std_logic_vector(2 DOWNTO 0);		 -- divider
      Oclk 							: out std_logic
      ); 
end clkDiv;

architecture behavior of clkDiv is

-- counter
signal count							: std_logic_vector(2 DOWNTO 0);
signal Oclk_i							: std_logic;

begin


Oclk <= Oclk_i;

-- create new clock frequency
count_clk :process(Iclk)
	begin
		if rst = '1' then
  			Oclk_i <= '0';
  			count <= (others => '0');
		elsif rising_edge(Iclk) then
   				 if count = (div - '1') then
      						count <= (others => '0');
      						Oclk_i <= '1';
      						
				 	if (Oclk_i = '1') then
						  Oclk_i <= '0';
			   		else
						  Oclk_i <= '1';
				   end if;
				   
    				 else
      						count <= count + '1';
			    end if;
		end if;
end process count_clk;

end behavior; 