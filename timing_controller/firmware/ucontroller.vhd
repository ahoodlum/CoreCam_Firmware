--------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Andrew Hood
--
-- Create Date:    07/17/2006
-- Design Name:    
-- Module Name:    uController
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:    Microcontroller for clock file decode and stimulation
--                 - 16-bit Program Counter (PC)
--                 - 16-bit Counters x4
--                 - 12 instructions
--                     - Jump if CX == (others => '0') to 'data'   (3 instr)
--                     - Jump directly to 'data'                   (1 instr)
--                     - Set CX = 'data'                           (3 instr)
--                     - Set dPtr to 'data'                        (1 instr)
--                     - Increment CX                              (1 instr)
--                     - NOP                                       (1 instr)
--                     TOTAL                                       (12 isntr)
--                 - OPCODE (36-bits):
--                    		INSTR - 12-bits               				DATA - 24-bits
--                  I I I I |I I I I | I I I I | D D D D | D D D D | D D D D | D D D D | D D D D | D D D D
-- Dependencies:
--                datarom.vhd
--                instrom.vhd
--                lineDelay.vhd
-- Revision:
-- Revision 0.01 - File Created, initial design
-- Revision 0.02	- Line delay added
-- Revision 0.03	- 1.6.2013; updated microcontroller to reflect latest version of PATGENII (V2.03)
--					- Generalized the output interface to be a 32 bit vector
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uControlRoicClk is
    Port ( uCclk       : in std_logic;                     -- Core microcontroller clock
           delayClk    : in std_logic;                     -- 300 MHz for 3.3 ns skew adjustment on ADC clocks
           rst         : in std_logic;
           sync		   : in std_logic;
		   clocks_out	: out std_logic_vector(35 DOWNTO 0)
			  );
end uControlRoicClk;

architecture Behavioral of uControlRoicClk is

component datarom is
    port ( CLK : in std_logic;
           ADDR : in std_logic_vector(19 DOWNTO 0);
           DOUT : out std_logic_vector(35 DOWNTO 0)
           );
end component;

component instrom is
    Port ( CLK : in std_logic;
           ADDR : in std_logic_vector(18 DOWNTO 0);
           DOUT : out std_logic_vector(35 DOWNTO 0)
           );
end component;

--component mux is
	--port ( din : 		IN array_of_slv;
		   --switch : 	IN std_logic_vector(7 DOWNTO 0);
		   --dout : 		OUT std_logic_vector(23 DOWNTO 0) 
		   --);
--end component;
--component lineDelay is
--    port(
--        clk       : in   std_logic;
--        rst       : in   std_logic;
--        I         : in   std_logic;
--        delayCnt  : in   std_logic_vector(7 DOWNTO 0);
--        O         : out  std_logic
--    );
--end component;

-- Counters
signal PC : std_logic_vector(18 DOWNTO 0);        -- Instr. Mem.   512k x 36 bits

signal C1, C2, C3, C4 : std_logic_vector(23 DOWNTO 0);
--signal C1_new, C2_new, C3_new, C4_new : std_logic_vector(23 DOWNTO 0);
--signal C1_inc, C2_inc, C3_inc, C4_inc : std_logic_vector(23 DOWNTO 0);
--signal C1_sel, C2_sel, C3_sel, C4_sel : std_logic;

signal JMPREG1, JMPREG2, JMPREG3 : std_logic_vector(18 DOWNTO 0);

-- Pointers      
signal dPtr 	: std_logic_vector(19 DOWNTO 0);      			-- Data Mem.     1M x 36 bits 

-- Instruction Decode
signal instrI_code : std_logic_vector(7 DOWNTO 0);     		-- Program Instruction Op Code
signal instrI_counters : std_logic_vector(4 DOWNTO 0);		-- Program Instruction counter flags 
signal instrD : std_logic_vector(23 DOWNTO 0);    			-- Program Data

-- internal buffers --
signal roicClk_i    : std_logic_vector(35 DOWNTO 0); 

signal increment_C1 : std_logic;
signal increment_C2 : std_logic;
signal increment_C3 : std_logic;
signal increment_C4 : std_logic;
signal increment_PM	: std_logic;

-- no connect stubs --
signal nc1 : std_logic_vector(1 DOWNTO 0);

--attribute syn_probe : boolean;
--attribute syn_probe of PC : signal is true;
--attribute syn_probe of instrI_code : signal is true;
--attribute syn_probe of increment_C1 : signal is true;
--attribute syn_probe of increment_C4 : signal is true;
--attribute syn_probe of dPtr : signal is true;
--attribute syn_probe of C1 : signal is true;
--attribute syn_probe of C2 : signal is true;
--attribute syn_probe of C3 : signal is true;
--attribute syn_probe of C4 : signal is true;

begin 

clocks_out				<=		roicClk_i;
instrI_code(7 DOWNTO 5) <= 		(others => '0'); 

increment_C1 <= instrI_counters(2);
increment_C2 <= instrI_counters(1);
increment_C3 <= instrI_counters(0);
increment_C4 <= instrI_counters(4);
increment_PM <= instrI_counters(3);

main: process (uCclk, rst, instrI_code, increment_C1, increment_C2, increment_C3, increment_C4)

begin
    		
    if rising_edge(uCclk) then
	
	if (rst = '1') then
        
		PC <= (others => '0');
		dPtr <= (others => '0');
    	C1 <= (others => '0');
        C2 <= (others => '0');
        C3 <= (others => '0');
		C4 <= (others => '0');
		
    else
	
        case instrI_code is
			-- NOP
            when x"00" =>
				PC <= PC + '1';
				
			-- Set dPtr to 'data' --
            when x"01" =>
                dPtr <= instrD(19 DOWNTO 0);
                PC <= PC + '1';
			
			-- Set CX = 'data' --     
            when x"02" =>
                C1 <= instrD;
                PC <= PC + '1';
			when x"03" =>
                C2 <= instrD;
                PC <= PC + '1';
			when x"04" =>
                C3 <= instrD;
                PC <= PC + '1';
                --dPtr <= dPtr + '1';
            when x"0E" =>
                C4 <= instrD;
                PC <= PC + '1';
                --dPtr <= dPtr + '1';
            
			-- Load Jump Register X
			when x"05" =>
				JMPREG1 <= instrD(18 DOWNTO 0);
				PC <= PC + '1';
			when x"06" =>
				JMPREG2 <= instrD(18 DOWNTO 0);
				PC <= PC + '1';
			when x"0F" =>
				JMPREG3 <= instrD(18 DOWNTO 0);
				PC <= PC + '1';
			
			-- Jump to address
			when x"07" =>
				PC <= instrD(18 DOWNTO 0);
	
            -- Jump if CX == (others => '0') to 'data' --
            when x"08" =>
                if (C1 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                else
                    PC <= PC + '1';
               end if;
			when x"09" =>
                if (C2 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                else
                    PC <= PC + '1';
                end if;
			when x"0A" =>
                if (C3 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                else
                    PC <= PC + '1';
                end if;
			when x"10" =>
				if (C4 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                else
                    PC <= PC + '1';
                end if;
			
			-- Jump No Sync Signal
			when x"0B" =>
				if (SYNC /= '1') then
					PC <= instrD(18 DOWNTO 0);
				else
					PC <= PC + '1';
				end if;
                
            -- Jump to address
            when x"0C" =>
				if (C1 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                elsif (C2 /= x"FFFFFF") then
                    PC <= JMPREG1;
				else
					PC <= PC + 1;
               end if;
			 when x"0D" =>
				if (C1 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                elsif (C2 /= x"FFFFFF") then
                    PC <= JMPREG1;
				elsif (C3 /= x"FFFFFF") then
					PC <= JMPREG2;
				else
					PC <= PC + 1;
               end if;
              when x"11" =>
				if (C1 /= x"FFFFFF") then
                    PC <= instrD(18 DOWNTO 0);
                elsif (C2 /= x"FFFFFF") then
                    PC <= JMPREG1;
				elsif (C3 /= x"FFFFFF") then
					PC <= JMPREG2;
				elsif (C4 /= x"FFFFFF") then
					PC <= JMPREG3;
				else
					PC <= PC + 1;
                end if;
            
			-- jmp masked sync	
			when x"12" =>
			
			-- load mask sync
			when x"13" =>
				
			when others =>
            
       end case;
	   end if;
       
	   if (increment_C1 = '1') then
			C1 <= C1 + 1;
		end if;	
		if (increment_C2 = '1') then
			C2 <= C2 + 1;
		end if;
		if (increment_C3 = '1') then
			C3 <= C3 + 1;
		end if;
		if (increment_C4 = '1') then
			C4 <= C4 + '1';
		end if;
		if (increment_PM = '1') then
			dPtr <= dPtr + '1';
		end if;
	
    end if;

	
	
end process;
		

dROM : datarom 
         port map (CLK => uCclk,
                   ADDR => dPtr,
                   DOUT => roicClk_i);

iROM : instrom
         port map (CLK => uCclk,
		 			ADDR => PC,
		 			DOUT(35 DOWNTO 34) => nc1,
		 			DOUT(33) => instrI_counters(4),
                   	DOUT(32 DOWNTO 28) => instrI_code(4 DOWNTO 0),
				   	DOUT(27 DOWNTO 24) => instrI_counters(3 DOWNTO 0), 
                   	DOUT(23 DOWNTO 0) => instrD);

end Behavioral;
