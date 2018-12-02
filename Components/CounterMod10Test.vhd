-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Simple counter test.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CounterMod10Test is
end CounterMod10Test;

architecture Behavioral of CounterMod10Test is

	component CounterMod10
	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
	     clk:  in  std_logic;								-- Clock signal
		  count:in  std_logic;								-- Count bit
		  c_out:out std_logic_vector(3 downto 0));	-- Counter state
	end component;

	signal rst:   std_logic;
	signal clk:   std_logic;
	signal count: std_logic;
	signal c_out: std_logic_vector(3 downto 0);
	
	constant clk_period: time := 10 ns;
begin
	
	uut:CounterMod10
	port map
	(
		rst => rst,
		clk => clk,
		count => count,
		c_out=> c_out
	);
	
	-- Clock transitions process:
	process
	begin
	
		if(clk='0') then
			clk<='1';
		else 
			clk<='0';
		end if;
		
		wait for clk_period/2;
		
	end process;
	
	process
	begin
		
		count <= '1';
		wait for 15*clk_period;
		
		rst <= '1';
		wait for 2*clk_period;
		
		rst <= '0'; 
		wait for 2*clk_period;
		
		count <= '1';
		wait for 15*clk_period;
		
		count <= '0';
		wait for 5*clk_period;
		
		wait;
	
	end process;
	
end Behavioral;

