library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity wb_to_timing_controller is
	port (
		-- TIMING CONTROLLER SIGNALS
		uC_clk			: in std_logic;		-- 10 kHz to 85 MHz
		delay_clk		: in std_logic;		-- 500 MHz clock
		rst				: in std_logic;
		sync			: in std_logic;
		
		clocks_out		: out std_logic_vector(7 DOWNTO 0);
		
		-- WISHBONE INTERFACE SIGNALS
		wb_clk_i		: in std_logic;
		wb_rst_i		: in std_logic;
		wb_dat_i		: in std_logic_vector(7 DOWNTO 0);
		wb_addr_i		: in std_logic_vector(7 DOWNTO 0);
		wb_cyc_i		: in std_logic;
		wb_stb_i		: in std_logic;
		wb_we_i			: in std_logic;
		wb_dat_o		: out std_logic_vector(7 DOWNTO 0);
		wb_ack_o		: out std_logic;
		wb_int_o 		: out std_logic 
		);
end wb_to_timing_controller;

architecture behavioral of wb_to_timing_controller is

component uControlRoicClk is
	Port ( 	
		uCclk      	: in std_logic;                     -- Core microcontroller clock
		delayClk   	: in std_logic;                      
		rst        	: in std_logic;
		sync		: in std_logic;
		clocks_out	: out std_logic_vector(35 DOWNTO 0)
	);
end component;

component lineDelay is
    port(
        clk       : in   std_logic;
        rst       : in   std_logic;
        I         : in   std_logic;
        delayCnt  : in   std_logic_vector(7 DOWNTO 0);
        O         : out  std_logic
    );
end component;

component mux_36_to_1 is
	port (
		data_in		: in std_logic_vector(35 DOWNTO 0);
		sel			: in std_logic_vector(5 DOWNTO 0);
		data_out 	: out std_logic
	);
end component;

signal wb_stb_d1		: std_logic;
signal wb_stb_d2		: std_logic;
signal wb_dat_local		: std_logic_vector(7 DOWNTO 0);
signal rd				: std_logic;
signal wr				: std_logic;

signal reg_00_i			: std_logic_vector(7 DOWNTO 0);
signal reg_01_i			: std_logic_vector(7 DOWNTO 0);
signal reg_02_i			: std_logic_vector(7 DOWNTO 0);
signal reg_03_i			: std_logic_vector(7 DOWNTO 0);
signal reg_04_i			: std_logic_vector(7 DOWNTO 0);
signal reg_05_i			: std_logic_vector(7 DOWNTO 0);
signal reg_06_i			: std_logic_vector(7 DOWNTO 0);
signal reg_07_i			: std_logic_vector(7 DOWNTO 0);
signal reg_08_i			: std_logic_vector(7 DOWNTO 0);
signal reg_09_i			: std_logic_vector(7 DOWNTO 0);
signal reg_D4_i			: std_logic_vector(7 DOWNTO 0);
signal reg_D5_i			: std_logic_vector(7 DOWNTO 0);
signal reg_D6_i			: std_logic_vector(7 DOWNTO 0);
signal reg_D7_i			: std_logic_vector(7 DOWNTO 0);

signal clocks_uC_i		: std_logic_vector(35 DOWNTO 0);
signal clocks_out_i		: std_logic_vector(35 DOWNTO 0);

begin

rd <= (not wb_we_i) and wb_cyc_i and wb_stb_i;
wr <= wb_we_i and wb_cyc_i and wb_stb_i;

wb_dat_o <= wb_dat_local;
wb_ack_o <= wb_stb_d1 and (not wb_stb_d2);

wb_int_o <= '1';

-- Pipeline STB for ACK so its generated on next clock
-- so there is time to register in wb_dat_local for response back.
-- Need to pipeline the write side to allow the read side time to read data
stb_pipeline1 : process(wb_clk_i, wb_rst_i)
	begin
		if rising_edge(wb_clk_i) or rising_edge(wb_rst_i) then
			if (wb_rst_i = '1') then
				wb_stb_d1 <= '1';
			else
				wb_stb_d1 <= wb_stb_i;
			end if;
		end if;
end process;

stb_pipeline2 : process(wb_clk_i, wb_rst_i)
	begin
		if rising_edge(wb_clk_i) or rising_edge(wb_rst_i) then
			if (wb_rst_i = '1') then
				wb_stb_d2 <= '1';
			else
				wb_stb_d2 <= wb_stb_d1 and wb_cyc_i;
			end if;	
		end if;
end process;

-- REGISTER READS AND WRITES
process(wb_clk_i, wb_rst_i)
begin
	if (wb_rst_i = '1') then
		reg_00_i <= (others => '0');		-- Clock Mux0 Select
		reg_01_i <= (others => '0');		-- Clock Mux1 Select		
		reg_02_i <= (others => '0');		-- Clock Mux2 Select
		reg_03_i <= (others => '0');		-- Clock Mux3 Select
		reg_04_i <= (others => '0');		-- Clock Mux4 Select
		reg_05_i <= (others => '0');		-- Clock Mux5 Select
		reg_06_i <= (others => '0');		-- Clock Mux6 Select
		reg_07_i <= (others => '0');		-- Clock Mux7 Select
		reg_08_i <= (others => '0');		-- Clock synthesizer subregister select
		reg_09_i <= (others => '0');		-- Clock synthesizer subregister data
		reg_D4_i <= (others => '0');	-- Clock delay 1
		reg_D5_i <= (others => '0');	-- Clock delay 2
		reg_D6_i <= (others => '0');	-- Clock delay 3
		reg_D7_i <= (others => '0');	-- Clock delay 4
		
	elsif (wb_cyc_i = '1') and (wb_stb_i = '1') then
		case wb_addr_i is
			when X"00" => 
				if (wr = '1') then
					reg_00_i <= wb_dat_i;
				else
					wb_dat_local <= reg_00_i;
				end if;
			when X"01" => 
				if (wr = '1') then
					reg_01_i <= wb_dat_i;
				else
					wb_dat_local <= reg_01_i;
				end if;
			when X"02" => 
				if (wr = '1') then
					reg_02_i <= wb_dat_i;
				else
					wb_dat_local <= reg_02_i;
				end if;
			when X"03" => 
				if (wr = '1') then
					reg_03_i <= wb_dat_i;
				else
					wb_dat_local <= reg_03_i;
				end if;
			when X"04" => 
				if (wr = '1') then
					reg_04_i <= wb_dat_i;
				else
					wb_dat_local <= reg_04_i;
				end if;
			when X"05" => 
				if (wr = '1') then
					reg_05_i <= wb_dat_i;
				else
					wb_dat_local <= reg_05_i;
				end if;
			when X"06" => 
				if (wr = '1') then
					reg_06_i <= wb_dat_i;
				else
					wb_dat_local <= reg_06_i;
				end if;
			when X"07" => 
				if (wr = '1') then
					reg_07_i <= wb_dat_i;
				else
					wb_dat_local <= reg_07_i;
				end if;
			when X"08" => 
				if (wr = '1') then
					reg_08_i <= wb_dat_i;
				else
					wb_dat_local <= reg_08_i;
				end if;
			when X"09" => 
				if (wr = '1') then
					reg_09_i <= wb_dat_i;
				else
					wb_dat_local <= reg_09_i;
				end if;
			when X"D4" => 
				if (wr = '1') then
					reg_D4_i <= wb_dat_i;
				else
					wb_dat_local <= reg_D4_i;
				end if;
			when X"D5" => 
				if (wr = '1') then
					reg_D5_i <= wb_dat_i;
				else
					wb_dat_local <= reg_D5_i;
				end if;
			when X"D6" => 
				if (wr = '1') then
					reg_D6_i <= wb_dat_i;
				else
					wb_dat_local <= reg_D6_i;
				end if;
			when X"D7" => 
				if (wr = '1') then
					reg_D7_i <= wb_dat_i;
				else
					wb_dat_local <= reg_D7_i;
				end if;
			when others =>
		end case;
	end if;
end process;

-- PATTERN GENERATOR INSTANTIATION
pat_gen : uControlRoicClk
	port map(
		uCclk => uC_clk,
		delayClk => delay_clk,
		rst => rst,
		sync => '1',
		clocks_out => clocks_uC_i
	);

clocks_out_i(17 DOWNTO 0) 	<= clocks_uC_i(17 DOWNTO 0);
clocks_out_i(35 DOWNTO 22) 	<= clocks_uC_i(35 DOWNTO 22);

-- ADC convert clock line delays
linedelay0 : lineDelay
	port map(
		clk => delay_clk,
		rst => rst,
		I => clocks_uC_i(18),
		delayCnt => reg_D4_i,
		O => clocks_out_i(18)
	);
linedelay1 : lineDelay
	port map(
		clk => delay_clk,
		rst => rst,
		I => clocks_uC_i(19),
		delayCnt => reg_D5_i,
		O => clocks_out_i(19)
	);
linedelay2 : lineDelay
	port map(
		clk => delay_clk,
		rst => rst,
		I => clocks_uC_i(20),
		delayCnt => reg_D6_i,
		O => clocks_out_i(20)
	);
linedelay3 : lineDelay
	port map(
		clk => delay_clk,
		rst => rst,
		I => clocks_uC_i(21),
		delayCnt => reg_D7_i,
		O => clocks_out_i(21)
	);

-- Clock output multiplexers
mux0 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_00_i(5 DOWNTO 0),
		data_out => clocks_out(0)
		);
mux1 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_01_i(5 DOWNTO 0),
		data_out => clocks_out(1)
		);
mux2 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_02_i(5 DOWNTO 0),
		data_out => clocks_out(2)
		);
mux3 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_03_i(5 DOWNTO 0),
		data_out => clocks_out(3)
		);
mux4 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_04_i(5 DOWNTO 0),
		data_out => clocks_out(4)
		);
mux5 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_05_i(5 DOWNTO 0),
		data_out => clocks_out(5)
		);		
mux6 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_06_i(5 DOWNTO 0),
		data_out => clocks_out(6)
		);
mux7 : mux_36_to_1
	port map(
		data_in => clocks_out_i,
		sel => reg_07_i(5 DOWNTO 0),
		data_out => clocks_out(7)
		);

end behavioral;
