library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity wb_to_timing_controller_tb is
end wb_to_timing_controller_tb;

architecture TB_ARCHITECTURE of wb_to_timing_controller_tb is
	-- Component declaration of the tested unit
	component wb_to_timing_controller
	port(
		wb_clk_i : in STD_LOGIC;
		wb_rst_i : in STD_LOGIC;
		wb_dat_i : in STD_LOGIC_VECTOR(7 downto 0);
		wb_addr_i : in STD_LOGIC_VECTOR(7 downto 0);
		wb_cyc_i : in STD_LOGIC;
		wb_stb_i : in STD_LOGIC;
		wb_we_i : in STD_LOGIC;
		wb_dat_o : out STD_LOGIC_VECTOR(7 downto 0);
		wb_ack_o : out STD_LOGIC;
		wb_int_o : out STD_LOGIC;
		reg_0 : out STD_LOGIC_VECTOR(7 downto 0);
		reg_1 : out STD_LOGIC_VECTOR(7 downto 0);
		reg_2 : out STD_LOGIC_VECTOR(7 downto 0);
		reg_3 : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal wb_clk_i : STD_LOGIC := '1';
	signal wb_rst_i : STD_LOGIC := '0';
	signal wb_dat_i : STD_LOGIC_VECTOR(7 downto 0);
	signal wb_addr_i : STD_LOGIC_VECTOR(7 downto 0);
	signal wb_cyc_i : STD_LOGIC := '0';
	signal wb_stb_i : STD_LOGIC := '0';
	signal wb_we_i : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal wb_dat_o : STD_LOGIC_VECTOR(7 downto 0);
	signal wb_ack_o : STD_LOGIC;
	signal wb_int_o : STD_LOGIC;
	signal reg_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal reg_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal reg_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal reg_3 : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...
	constant PERIOD : time := 20 ns;
	
begin

	-- Unit Under Test port map
	UUT : wb_to_timing_controller
		port map (
			wb_clk_i => wb_clk_i,
			wb_rst_i => wb_rst_i,
			wb_dat_i => wb_dat_i,
			wb_addr_i => wb_addr_i,
			wb_cyc_i => wb_cyc_i,
			wb_stb_i => wb_stb_i,
			wb_we_i => wb_we_i,
			wb_dat_o => wb_dat_o,
			wb_ack_o => wb_ack_o,
			wb_int_o => wb_int_o,
			reg_0 => reg_0,
			reg_1 => reg_1,
			reg_2 => reg_2,
			reg_3 => reg_3
		);

	-- Add your stimulus here ...
	wb_clk_i <= not wb_clk_i after PERIOD/2;
	
	process
	begin
		wait for PERIOD*5;
		wb_rst_i <= '0';
		wait for PERIOD;
		wb_rst_i <= '1';
		wait for PERIOD*5;
		wb_rst_i <= '0';
		wait for PERIOD*5;
		wb_dat_i <= X"A5";
		wb_addr_i <= X"02";
		wb_we_i <= '1';
		wb_stb_i <= '1';
		wb_cyc_i <= '1';
		wait for PERIOD*2;
		wb_we_i <= '0';
		wb_stb_i <= '0';
		wb_cyc_i <= '0';
		wait for PERIOD * 10;
		wb_stb_i <= '1';
		wb_cyc_i <= '1';
		wait for PERIOD*2;
		wb_we_i <= '0';
		wb_stb_i <= '0';
		wb_cyc_i <= '0';
		wait for PERIOD * 10;
		wait for PERIOD * 500; 
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_wb_to_timing_controller of wb_to_timing_controller_tb is
	for TB_ARCHITECTURE
		for UUT : wb_to_timing_controller
			use entity work.wb_to_timing_controller(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_wb_to_timing_controller;

