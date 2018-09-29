-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Test for the coder 8to3 desingned.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testCoder8to3 is
end testCoder8to3;

architecture testBench of testCoder8to3 is
-- Component to test, our coder
component Coder8to3
	port(input:   in std_logic_vector(7 downto 0);
		  output: out std_logic_vector(2 downto 0));
end component;

-- Signals we need for the data
signal i: std_logic_vector(7 downto 0);
signal o: std_logic_vector(2 downto 0);

begin
coder: Coder8to3 port map(
	input  => i,
	output => o);
	
process
begin
	i <= "00000000";
	wait for 100 ns;
	i <= "00000001";
	wait for 100 ns;
	i <= "00000010";
	wait for 100 ns;
	i <= "00000100";
	wait for 100 ns;
	i <= "01111110";
	wait for 100 ns;
	i <= "10000010";
	wait for 100 ns;
	i <= "00111111";
	wait for 100 ns;
	i <= "11111111";
	wait;
end process;

end testBench;

