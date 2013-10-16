Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_generator is
	port(
	clk		:	in std_logic;
	reset	:	out std_logic
	);
end reset_generator;

architecture behavioral of reset_generator is

signal counter 			: natural := 0;
constant reset_zero		: natural := 10000;
constant reset_start	: natural := 20000;
constant reset_stop		: natural := 30000;

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			counter <= counter + 1;
		end if;
	end process;
	
	process(counter)
	begin
		if (counter > reset_zero) then 
			if (counter < reset_start) then
				reset <= '0';
			elsif (counter < reset_stop) then
				reset <= '1';
			elsif (counter >= reset_stop) then
				reset <= '0';
			end if;
		else
			reset <= '0';
		end if;	
	end process;

end architecture;
	
	
	
		

