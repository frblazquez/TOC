-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Simple counter test.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CounterNBitsTest is
end CounterNBitsTest;

architecture Behavioral of CounterNBitsTest is

	component CounterNBits
		generic(N: natural := 4);								-- Counter width
		port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
		     clk:  in  std_logic;								-- Clock signal
			  load: in  std_logic;								-- Load control bit
			  count:in  std_logic;								-- Count bit
			  c_in: in  std_logic_vector(N-1 downto 0);	-- Parallel load bits
			  c_out:out std_logic_vector(N-1 downto 0));	-- Counter state
	end component;

	signal rst:   std_logic;
	signal clk:   std_logic;
	signal load:  std_logic;
	signal count: std_logic;
	signal c_in:  std_logic_vector(3 downto 0);
	signal c_out: std_logic_vector(3 downto 0);
	
	constant clk_period: time := 10 ns;
begin
	
	uut:CounterNBits 
	generic map(N=>4)	
	port map
	(
		rst => rst,
		clk => clk,
		load => load,
		count => count,
		c_in => c_in,
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
		
		rst <= '1';
		wait for 2*clk_period;
		
		rst <= '0'; 
		wait for 2*clk_period;
		
		c_in <= "1111";
		wait for clk_period;
		
		load <= '1';
		wait for clk_period;
		
		load <= '0';
		wait for 2*clk_period;
		
		count <= '1';
		wait for 30*clk_period;
		
		wait;
	
	end process;
	
end Behavioral;

