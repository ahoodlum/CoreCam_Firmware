library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity video_generator is
	port (
		clk			: in	std_logic;
		rst			: in	std_logic;
		fsync		: in	std_logic;
		lsync		: in	std_logic;
		video_data	: out std_logic_vector(15 DOWNTO 0)
		);
end video_generator;

architecture behavioral of video_generator is

	component edgeDetect is
		port (
        
        clk       :    in std_logic;
        rst       :    in std_logic;
        strobe    :    in std_logic;
        E         :    out std_logic
    	);
	end component;
	
	component dual_edge_counter
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(10 downto 0) );
	end component;
	
	signal 	line_count	: std_logic_vector(10 DOWNTO 0);
	signal	pixel_count	: std_logic_vector(10 DOWNTO 0);
	signal	pixel_count_reset : std_logic;
	signal	pixel_data	: std_logic_vector(15 DOWNTO 0);
	signal 	fsync_detected, lsync_detected	: std_logic;
	
begin	
	
	pixel_count_reset <= fsync_detected or lsync_detected;
	
	fsync_detect : edgeDetect
	port map (
		clk => clk,
		rst => rst,
		strobe => fsync,
		E => fsync_detected
	); 
	
	lsync_detect : edgeDetect
	port map (
		clk => clk,
		rst => rst,
		strobe => lsync,
		E => lsync_detected
	);
	
	pixel_counter : dual_edge_counter
	port map (
		clk => clk,
		rst => pixel_count_reset,
		output => pixel_count
	);	
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (fsync_detected = '1') then
				pixel_data <= (others => '0');
				line_count <= (others => '0');
				--pixel_count <= (others => '0');
			elsif (lsync_detected = '1') then
				line_count <= line_count + '1';
				--pixel_count <= (others => '0');
			--else
				--pixel_count <= pixel_count + 1;
			end if;
		end if;		
	end process;
				
	video_data <= "00" & line_count(3 DOWNTO 0) & pixel_count(9 DOWNTO 0);
end behavioral;
		
			