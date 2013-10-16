library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dual_edge_counter is
  port ( 	clk				:	in 	std_logic;
			rst				:	in 	std_logic;
			output			:	out std_logic_vector(10 downto 0) );
		  
end dual_edge_counter;

architecture Structural of dual_edge_counter is
	signal counter :std_logic_vector(10 downto 0) := (others=>'0');

	begin
 
process (clk)
 begin
	if rst = '1' then
		counter <= (others => '0');
	elsif (falling_edge(clk)) then		
		counter <= counter + 2;
	end if;	
end process;

	output <= counter when clk='0'
	else (counter or "00000000001");

end Structural;