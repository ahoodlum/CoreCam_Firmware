library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library lattice;
use lattice.components.all;

library machxo2;
use machxo2.all;

entity timing_controller_top is
	port (
			uart_sout	:	out std_logic;
			uart_sin	:	in 	std_logic;
			clock_out	:	out std_logic_vector(7 DOWNTO 0);
			video_data	:	out	std_logic_vector(15 DOWNTO 0);
			leds_out	:	out std_logic_vector(3 DOWNTO 0);
			led0		:	out	std_logic
	);
end timing_controller_top;	

architecture behavioral of timing_controller_top is

	component reset_generator is
		port(
			clk		:	in std_logic;
			reset	:	out std_logic
			);
	end component;

	component wb_to_timing_controller is
		port (
			-- TIMING CONTROLLER SIGNALS
			uC_clk			: in std_logic;
			delay_clk		: in std_logic;
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
	end component;
	
--component uControlRoicClk is
		--Port ( 	
			--uCclk      	: in std_logic;                     -- Core microcontroller clock
			--delayClk   	: in std_logic;                     -- 
			--rst        	: in std_logic;
			--sync		: in std_logic;
			--clocks_out	: out std_logic_vector(35 DOWNTO 0)
		--);
	--end component;
	
--	component mux_36_to_1 is
--		port (
--			data_in		: in std_logic_vector(35 DOWNTO 0);
--			sel			: in std_logic_vector(5 DOWNTO 0);
--			data_out 	: out std_logic
--		);
--	end component;
	
	 component video_generator is
	 port (
		 clk			: in	std_logic;
		 rst			: in	std_logic;
		 fsync			: in	std_logic;
		 lsync			: in	std_logic;
		 video_data		: out std_logic_vector(15 DOWNTO 0)
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
    	GENERIC  (NOM_FREQ: string := "88.67");
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
	attribute NOM_FREQ of OSCInst0 : label is "88.67";
	
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
	
	component timing_controller -- MICO8 microcontroller
		port(
		  clk_i   : in std_logic
		  ; reset_n : in std_logic
		  ; LEDPIO_OUT : out std_logic_vector(3 downto 0)
		  ; uartSIN : in std_logic
		  ; uartSOUT : out std_logic
		  ; timing_controllerclk : out std_logic
		  ; timing_controllerrst : out std_logic
		  ; timing_controllerslv_adr : out std_logic_vector(31 downto 0)
		  ; timing_controllerslv_master_data : out std_logic_vector(7 downto 0)
		  ; timing_controllerslv_slave_data : in std_logic_vector(7 downto 0)
		  ; timing_controllerslv_strb : out std_logic
		  ; timing_controllerslv_cyc : out std_logic
		  ; timing_controllerslv_ack : in std_logic
		  ; timing_controllerslv_err : in std_logic
		  ; timing_controllerslv_rty : in std_logic
		  ; timing_controllerslv_sel : out std_logic_vector(3 downto 0)
		  ; timing_controllerslv_we : out std_logic
		  ; timing_controllerslv_bte : out std_logic_vector(1 downto 0)
		  ; timing_controllerslv_cti : out std_logic_vector(2 downto 0)
		  ; timing_controllerslv_lock : out std_logic
		  ; timing_controllerintr_active_high : in std_logic
		  );
   end component;
	
	signal LEDPIO_out							: std_logic_vector(3 DOWNTO 0);
	signal timing_controllerclk_i 				: std_logic;
	signal timing_controllerrst_i				: std_logic;
	signal timing_controllerslv_adr_i			: std_logic_vector(31 DOWNTO 0);
	signal timing_controllerslv_master_data_i 	: std_logic_vector(7 DOWNTO 0);
	signal timing_controllerslv_slave_data_i	: std_logic_vector(7 DOWNTO 0);
	signal timing_controllerslv_strb_i			: std_logic;
	signal timing_controllerslv_cyc_i			: std_logic;
	signal timing_controllerslv_ack_i			: std_logic;
	signal timing_controllerslv_err_i			: std_logic;
	signal timing_controllerslv_rty_i			: std_logic;
	signal timing_controllerslv_sel_i			: std_logic_vector(3 DOWNTO 0);
	signal timing_controllerslv_we_i			: std_logic;
	signal timing_controllerslv_bte_i			: std_logic_vector(1 DOWNTO 0);
	signal timing_controllerslv_cti_i			: std_logic_vector(2 DOWNTO 0);
	signal timing_controllerslv_lock_i			: std_logic;
	signal timing_controllerintr_active_high_i	: std_logic;
	
	signal 	delayClk_4x_i	: std_logic;
	signal	rst_i			: std_logic;
	signal	rst_i_stub		: std_logic := '0';
	signal 	clk_i			: std_logic;
	--attribute syn_probe : boolean;
	--attribute syn_probe of clk_i : signal is true;
	--attribute syn_probe of delayClk_4x_i : signal is true;
	
	-- signal	sync_i			: std_logic;
	signal clocks_out_i			: std_logic_vector(7 DOWNTO 0);
	signal stdby_sed_stub_i		: std_logic;
	signal clk_divx_stub_i		: std_logic;
	signal video_data_i			: std_logic_vector(15 DOWNTO 0);
	signal clk_stub, fsync_stub, lsync_stub : std_logic;

begin
	video_data <= video_data_i;
	--rst_out <= rst_i;
   	--clk_out	<= clk_i;
	--clock_out <= clocks_out_i(8) & clocks_out_i(14) & clocks_out_i(13) & clocks_out_i(12) & clocks_out_i(9) & clocks_out_i(10) & clocks_out_i(7) & clocks_out_i(0);	
	
	reset_gen : reset_generator
		port map(
			clk => clk_i,
			reset => rst_i
		);
	
	--pat_gen : uControlRoicClk
		--port map(
			--uCclk => delayClk_4x_i,
			--delayClk => clk_i,
			--rst => rst_i,
			--sync => '1',
			--clocks_out => clocks_out_i
		--);

	OSCInst0: OSCH
	--	 synthesis translate_off
	GENERIC MAP ( NOM_FREQ  => "88.67" )
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
			RST => rst_i_stub,
			CLKI => clk_i,
			ALIGNWD => '0',	-- word alignment used in high speed interfaces
			CDIV1 => clk_divx_stub_i, --
			CDIVX => delayClk_4x_i
			);
		
	 video_gen : video_generator
		 port map (
			 clk => clk_stub,
			 rst => rst_i,	
			 fsync => fsync_stub,
			 lsync => lsync_stub,
			 video_data => video_data_i
		 );
		
	led0_blinker : led_blinker
		port map (
			clk => clk_i,
			rst => rst_i,
			led => led0
		);

	lm8_inst : timing_controller
	port map (
		clk_i  => clk_i
	   ,reset_n  => rst_i
	   ,LEDPIO_OUT  => LEDPIO_OUT
	   ,uartSIN  => uart_sin
	   ,uartSOUT  => uart_sout
	   ,timing_controllerclk  => timing_controllerclk_i
	   ,timing_controllerrst  => timing_controllerrst_i
	   ,timing_controllerslv_adr  => timing_controllerslv_adr_i
	   ,timing_controllerslv_master_data  => timing_controllerslv_master_data_i
	   ,timing_controllerslv_slave_data  => timing_controllerslv_slave_data_i
	   ,timing_controllerslv_strb  => timing_controllerslv_strb_i
	   ,timing_controllerslv_cyc  => timing_controllerslv_cyc_i
	   ,timing_controllerslv_ack  => timing_controllerslv_ack_i
	   ,timing_controllerslv_err  => timing_controllerslv_err_i
	   ,timing_controllerslv_rty  => timing_controllerslv_rty_i
	   ,timing_controllerslv_sel  => timing_controllerslv_sel_i
	   ,timing_controllerslv_we  => timing_controllerslv_we_i
	   ,timing_controllerslv_bte  => timing_controllerslv_bte_i
	   ,timing_controllerslv_cti  => timing_controllerslv_cti_i
	   ,timing_controllerslv_lock  => timing_controllerslv_lock_i
	   ,timing_controllerintr_active_high  => timing_controllerintr_active_high_i
   );
   
 
   pat_gen : wb_to_timing_controller
	port map (
		-- TIMING CONTROLLER SIGNALS
		uC_clk => delayClk_4x_i,
		delay_clk => clk_i,	
		rst => rst_i,
		sync => '0',
		clocks_out => clocks_out_i,
		
		-- WISHBONE INTERFACE SIGNALS
		wb_clk_i => timing_controllerclk_i,
		wb_rst_i => timing_controllerrst_i,
		wb_dat_i => timing_controllerslv_master_data_i,
		wb_addr_i => timing_controllerslv_adr_i(7 DOWNTO 0),	
		wb_cyc_i => timing_controllerslv_cyc_i,		
		wb_stb_i => timing_controllerslv_strb_i,	
		wb_we_i	=> timing_controllerslv_we_i,
		wb_dat_o => timing_controllerslv_slave_data_i,	
		wb_ack_o => timing_controllerslv_ack_i,
		wb_int_o => timing_controllerintr_active_high_i 	
		);

end behavioral;