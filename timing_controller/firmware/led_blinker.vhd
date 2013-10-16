library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity led_blinker is
	port (
		clk		: in	std_logic;
		rst		: in	std_logic;
		led		: out	std_logic
	);
end led_blinker;

architecture behavioral of led_blinker is

signal led_i : std_logic;

begin
	
	led_flash_proc : process(clk, rst)
    constant RATIO : integer := 13000000;       	-- how much to slow it down: 13,000,000 times => 53MHz becomes 4Hz
    variable count : integer range 0 to RATIO-1;  	-- register that keeps the count
    begin
        if rst='1' then      -- reset mode
            led_i <= '0';        -- start with LED off
            count := 0;
        elsif rising_edge(clk) then
            if count = RATIO-1 then       	-- count has reached the preset value
                count := 0;             	-- reset count
                led_i <= not led_i;       -- toggle LED
            else
                count := count + 1;
            end if;
        end if;
    end process;
    led <= led_i;     -- drive led1 to the external world

end behavioral;
	