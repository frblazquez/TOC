-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Car washer.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestBench is
end TestBench;

architecture Behavioral of TestBench is

	component CarWasher is
	 port(clk:  in std_logic;		-- Synchronous transitions
			rst:  in std_logic;		-- Back to initial state
			init: in std_logic;		-- Starts the coins lecture
			coin: in std_logic;		-- Another coin came
			wash: in std_logic;		-- Starts the wash
			Wend: in std_logic;		-- Signal to end the water flow
			Send: in std_logic;		-- Signal to end the soap flow
			water:  out std_logic;	-- Activates the water
			soap:   out std_logic;	-- Activates the soap
			finish: out std_logic);  -- The wash has finished
	end component;

	signal clk:  std_logic;
	signal rst:  std_logic;
	signal init: std_logic;		
	signal coin: std_logic;	
	signal wash: std_logic;	
	signal Wend: std_logic;	
	signal Send: std_logic;	
	signal water:  std_logic;
	signal soap:   std_logic;	
	signal finish: std_logic;  
	
	constant clk_time:   time := 50 ns;
	constant clk_period: time := 2*clk_time;
	
begin

uut: CarWasher port map
(
	clk    => clk,
	rst    => rst,
	init   => init,		
	coin   => coin,	
	wash   => wash,	
	Wend   => Wend,	
	Send   => Send,
	water  => water,
	soap   => soap,	
	finish => finish 
);

process 
begin
	
	if(clk='1') then 
		clk<='0';
	else
		clk<='1';
	end if;
	
	wait for clk_time;
	
end process;

process
begin

	wait for 75 ns;			-- Defase with clk rising edge
	
	wait for 2*clk_period;	-- Just to check that the wash doesn't start
	
	init <= '0';				-- Wash should't start yet! (Init='0')	
	coin <= '1';				-- Value 1 just for disturbing
	wash <= '1';	
	Wend <= '1';	
	Send <= '1';
	
	wait for 2*clk_period;
	
	coin <= '0';				-- Value 0 just for checking
	wash <= '0';	
	Wend <= '0';	
	Send <= '0';	
	
	wait for 2*clk_period;
	
	init <= '1';   			-- Start dancing
				
	coin <= '0';	         -- Don't read coins yet
	wash <= '0';	
	Wend <= '1';	
	Send <= '1';

	wait for 5*clk_period;
	
	coin <= '1';				-- Read just one coin
	
	wait for clk_period;
	
	coin <= '0';        		-- Wait a little bit without coins
	
	wait for 3*clk_period;
	
	wash <= '1';				-- Start washing (water)
	
	coin <= '1';
	Wend <= '0';	
	Send <= '1';
	
	wait for 2*clk_period;
	
	Wend <= '1';
	Send <= '0';
	init <= '0';
	
	wait for 3*clk_period; 	-- Shoulds go back to initial state
	
	wait;

end process;


end Behavioral;

