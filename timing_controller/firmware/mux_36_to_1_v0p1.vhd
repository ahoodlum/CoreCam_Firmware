library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_36_to_1 is
	port (
		data_in		: in std_logic_vector(35 DOWNTO 0);
		sel			: in std_logic_vector(5 DOWNTO 0);
		data_out 	: out std_logic
		);
end mux_36_to_1;

architecture behavioral of mux_36_to_1 is
begin

	with sel select data_out	<= 	
				data_in(0) 	when "000000",	
				data_in(1) 	when "000001",
				data_in(2) 	when "000010",
				data_in(3) 	when "000011",
				data_in(4) 	when "000100",
				data_in(5) 	when "000101",
				data_in(6) 	when "000110",
				data_in(7) 	when "000111",
				data_in(8) 	when "001000",
				data_in(9) 	when "001001",	
				data_in(10)	when "001010",
				data_in(11)	when "001011",	
				data_in(12)	when "001100",
				data_in(13)	when "001101",
				data_in(14)	when "001110",
				data_in(15) when "001111",
				data_in(16)	when "010000",
				data_in(17)	when "010001",
				data_in(18) when "010010",
				data_in(19) when "010011",
				data_in(20) when "010100",
				data_in(21)	when "010101",
				data_in(22)	when "010110",
				data_in(23)	when "010111",
				data_in(24)	when "011000",
				data_in(25) when "011001", 
				data_in(26)	when "011010",
				data_in(27)	when "011011",
				data_in(28)	when "011100",
				data_in(29)	when "011101",
				data_in(30)	when "011110",
				data_in(31)	when "011111",
				data_in(32)	when "100000",
				data_in(33)	when "100001",
				data_in(34) when "100010",
				data_in(35)	when "100011",
				data_in(0)	when others;		

end behavioral;