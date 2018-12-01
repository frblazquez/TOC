-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for the generic register designed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PushButtonDebouncerTest is
end PushButtonDebouncerTest;

architecture Behavioral of PushButtonDebouncerTest is
	
	-- Component we are testing, debouncer:
	component PushButtonDebouncer
	port(rst:  in  std_logic;			-- Reset signal (asynchronous)
		  clk:  in  std_logic;			-- Clock signal (expected 100MHz signal)
		  x:    in  std_logic;			-- Input from the push button or switch
		  xDeb: out std_logic;			-- x signal debounced ~ x signal steadier
		  xDebFalling: out std_logic;	-- Indicates when x signal goes from high to low
		  xDebRising:  out std_logic);-- Indicates when x signal goes from low to high
	end component;

	
	-- 100MHz clock frecuency
	constant clk_period: time := 10 ns;
	
	signal clk: std_logic;
	signal rst: std_logic;
	signal x:   std_logic;
	signal xDeb:std_logic;
	signal xDebFalling: std_logic;
	signal xDebRising:  std_logic;
	
begin

	-- Clock signal process
	process
	begin
		
		if(clk='0') then 
			clk<='1';
		else      
			clk<='0';
		end if;
		
		wait for clk_period/2;
		
	end process;
	
	uut: PushButtonDebouncer port map
	(
		rst => rst,
		clk => clk,
		x   => x,
		xDeb=> xDeb,
		xDebRising => xDebRising,
		xDebFalling=> xDebFalling
	);
	
	process
	begin
		
		rst<='1';
		x <='0';
		wait for 10 ms;
		
		rst<='0';
		wait for 10 ms;
		
		x <= '1';
		wait for 200 ms;
		
		x <= '0';
		wait for 200 ms;
		
		wait;
	
	end process;

end Behavioral;

