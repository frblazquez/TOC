-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Simulation for the practise 2. 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.All;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pr2SIm is
end pr2SIm;

architecture Behavioral of pr2SIm is

	-- Unit under test
	component Pr2 is
	port(rst: 	     in std_logic;	-- From a push button and asynchronous
		  clk: 	     in std_logic;	-- For the push button implementation
		  check:	     in std_logic; 	-- From push button (and throught debouncer)
		  key_entry:  in std_logic_vector(7 downto 0); -- From the switches
		  unlocked:  out std_logic;	-- Showed at the leds bench
		  remaining: out std_logic_vector(6 downto 0));-- 7 segments display	  
	end component;
	
	-- Signals
	signal rst,clk,check,unlocked: std_logic := '0';
	signal key: std_logic_vector(7 downto 0);
	signal remaining: std_logic_vector(6 downto 0);
	
begin

	uut: Pr2 port map 
	(
		rst => rst,
		clk => clk,
		check => check,
		key_entry => key,
		unlocked => unlocked,
		remaining => remaining	
	);
	
	-- 100 ns period for the clok (much more than the fpga one)
	process 
	begin
		if(clk='1') then
			clk <= '0';
		else 
			clk <= '1';
		end if;
		
		wait for 20 ns;
	end process;
	
	-- Test cases
	process
	begin
		rst <= '0';
		wait for 25 ns;
		
		rst <= '1';
		
		-- Prueba 1 sin confirmación de clave
		key <= "01010101";
		wait for 100 ns;
		
		check <= '1';
		wait for 200 ns;
		
		key <= "00000000";
		check <= '0';
		wait for 300 ns;
		
		rst <= '0';
		wait for 100 ns;
		
		check <= '1';
		wait for 150 ns;
		
		rst <= '1';
		wait for 200 ns;
		
		key <= "01010101"; 
		check <= '0';
		wait for 150 ns;
		
		check <= '1';
		wait for 150 ns;
		
		key <= "01010101";
		check <= '0';
		wait for 150 ns;
		
		check <= '1';
		wait for 150 ns;
		
		wait;
	end process;


end Behavioral;

