library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library lattice;
use lattice.components.all;

library machxo2;
use machxo2.all;

entity pat_gen_top is
	port (
		--	clk			:	in 	std_logic;
		--	clk_fast	:	in 	std_logic;
			uart_rx		:	in 	std_logic;
			uart_tx		: 	out std_logic;
			clock_out	:	out std_logic_vector(7 DOWNTO 0);
			video_data	:	out	std_logic_vector(15 DOWNTO 0);
			led0		:	out	std_logic;
			clocks_out	:	out std_logic_vector(35 DOWNTO 0)
	);
end pat_gen_top;	

architecture behavioral of pat_gen_top is

	component reset_generator is
		port(
			clk		:	in std_logic;
			reset	:	out std_logic
			);
	end component;

	component uControlRoicClk is
		Port ( 	
			uCclk      	: in std_logic;                     -- Core microcontroller clock
			delayClk   	: in std_logic;                     -- 300 MHz for 3.3 ns skew adjustment on ADC clocks
			rst        	: in std_logic;
			sync		: in std_logic;
			clocks_out	: out std_logic_vector(35 DOWNTO 0)
		);
	end component;
	
	component mux_36_to_1 is
		port (
			data_in		: in std_logic_vector(35 DOWNTO 0);
			sel			: in std_logic_vector(5 DOWNTO 0);
			data_out 	: out std_logic
		);
	end component;
	
	component video_generator is
	port (
		clk			: in	std_logic;
		rst			: in	std_logic;
		fsync		: in	std_logic;
		lsync		: in	std_logic;
		video_data	: out std_logic_vector(15 DOWNTO 0)
		);
	end component;
	
	component led_blinker is
		port(
			clk		:	in std_logic;
			rst		:	in std_logic;
			led		:	out std_logic
			);
	end component;
	
	component OSCH
	-- synthesis translate_off
    	GENERIC  (NOM_FREQ: string := "53.20");
	-- synthesis translate_on
      PORT ( 
			stdby 		:IN std_logic;
			osc			:OUT std_logic;
			sedstdby	:OUT std_logic
		);
	end component;
	attribute syn_noprune: boolean ;
	attribute syn_noprune of OSCH: component is true;
	
	attribute NOM_FREQ	: string;
	attribute NOM_FREQ of OSCInst0 : label is "53.20";
	
	component CLKDIVC
		generic (	
			DIV : string;
			GSR : string
			);
		port (
			RST : in std_logic;
			CLKI : in std_logic;
			ALIGNWD : in std_logic;
			CDIV1 : out std_logic;
			CDIVX : out std_logic);
	end component;

	--attribute NOM_FREQ : string;
    --attribute NOM_FREQ of OSCinst0 : label is "133.00";	 
	
	signal 	delayClk_4x_i	: std_logic;
	signal	rst_i			: std_logic;
	signal 	clk_i			: std_logic;
	attribute syn_probe : boolean;
	attribute syn_probe of clk_i : signal is true;
	attribute syn_probe of delayClk_4x_i : signal is true;
	
	-- signal	sync_i			: std_logic;
	signal 	clocks_out_i	: std_logic_vector(35 DOWNTO 0);

	signal stdby_sed_stub_i		: std_logic;
	signal clk_divx_stub_i		: std_logic;
	

begin

	uart_tx <= uart_rx;
	clocks_out <= clocks_out_i;
	
	
	reset_gen : reset_generator
		port map(
			clk => clk_i,
			reset => rst_i
		);
	
	pat_gen : uControlRoicClk
		port map(
			uCclk => delayClk_4x_i,
			delayClk => clk_i,
			rst => rst_i,
			sync => '1',
			clocks_out => clocks_out_i
		);

	-- SYS_PXC
	mux0 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "000000",
			data_out => clock_out(0)
		);
	-- FPA_CLK
	mux1 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "000111",
			data_out => clock_out(1)
		);
	-- FRAME
	mux2 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001010",
			data_out => clock_out(2)
		);
	-- LINE
	mux3 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001001",
			data_out => clock_out(3)
		);
	-- S_CLK
	mux4 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001100",
			data_out => clock_out(4)
		);
	-- S_EN
	mux5 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001101",
			data_out => clock_out(5)
		);
	-- S_IN
	mux6 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001110",
			data_out => clock_out(6)
		);
	-- EXP
	mux7 : mux_36_to_1
		port map(
			data_in => clocks_out_i,
			sel => "001000",
			data_out => clock_out(7)
		);

	OSCInst0: OSCH
	--	 synthesis translate_off
	GENERIC MAP ( NOM_FREQ  => "53.20" )
	--	 synthesis translate_on
	PORT MAP ( 
			stdby		=>  '0',
			osc			=>  clk_i,
			sedstdby	=>  stdby_sed_stub_i
	);
		
		I1: CLKDIVC
			generic map ( 
				DIV => "4.0",
				GSR => "DISABLED"
				)
			port map ( 
				RST => rst_i,
				CLKI => clk_i,
				ALIGNWD => '0',	-- word alignment used in high speed interfaces
				CDIV1 => clk_divx_stub_i, --
				CDIVX => delayClk_4x_i
				);
		
	video_gen : video_generator
		port map (
			clk => clocks_out_i(7),
			rst => rst_i,	
			fsync => clocks_out_i(10),
			lsync => clocks_out_i(9),
			video_data => video_data
		);
		
	led0_blinker : led_blinker
		port map (
			clk => clk_i,
			rst => rst_i,
			led => led0
		);
		--I2: CLKDIVC
			--generic map ( 
				--DIV => "4.0",
				--GSR => "DISABLED"
				--)
			--port map ( 
				--RST => rst_i,
				--CLKI => delayClk_4x_i,
				--ALIGNWD => '0',	-- word alignment used in high speed interfaces
				--CDIV1 => open, --
				--CDIVX => uCclk_i
				--);
end behavioral;