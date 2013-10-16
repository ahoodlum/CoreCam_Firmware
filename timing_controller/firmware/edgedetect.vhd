LIBRARY IEEE;
USE IEEE.std_logic_1164.all ;

entity edgeDetect is
    port (
        
        clk       :    in std_logic;
        rst       :    in std_logic;
        strobe    :    in std_logic;
        E         :    out std_logic
    );
end edgeDetect;



architecture behavioral of edgeDetect is

signal rDin, rrDin : std_logic;

begin

process (clk,rst)
   begin
      if (rst = '1') then
         rDIn <= '0';
         rrDin <= '0';
         E <= '0';
      elsif rising_edge(clk) then
         rDIN <= strobe;
         rrDin <= rDin;
         --E <= rDin xor rrDin; -- any edge
         E <= rDIn and not rrDin; -- rising etc...
      end if;
end process;

    

end behavioral;