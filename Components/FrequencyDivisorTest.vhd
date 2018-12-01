-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Frequency divisor. From 100MHz to 1Hz.
-- This component can be easily modified for changing
-- the output frequency to any old.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FrequencyDivisorTest is
end FrequencyDivisorTest;

architecture Behavioral of FrequencyDivisorTest is

	component FrequencyDivisor
		port(rst:     in  std_logic; -- Reset signal (asynchronous)
			  clk_in:  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)
			  clk_out: out std_logic);-- Clock signal output (Will be 1/100M clock input frequency)
	end component;

	signal rst: std_logic := '0';
	signal clk_in: std_logic;
	signal clk_out:std_logic;
begin

	 uut: FrequencyDivisor port map
	(
			rst=> rst,
			clk_in=> clk_in,
			clk_out=> clk_out
	);
	
	-- Clock transitions process:
	process
	begin
	
		if(clk_in='0') then
			clk_in<='1';
		else 
			clk_in<='0';
		end if;
		
		wait for 10 ns;
		
	end process;
	
end Behavioral;

