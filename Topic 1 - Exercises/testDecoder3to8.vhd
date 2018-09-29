-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Test for the 3to8 decoder designed.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

entity testDecoder3to8 is
end testDecoder3to8;

architecture testBench of testDecoder3to8 is
-- The decoder we are testing
component Decoder3to8 
	port(input: in  std_logic_vector(2 downto 0);
		 output: out std_logic_vector(7 downto 0));
end component;

-- Signals or wires to the decoder ports
signal i: std_logic_vector(2 downto 0);
signal o: std_logic_vector(7 downto 0);

begin
-- Instanciate the decoder (conect it)
decoder: Decoder3to8 port map(
	input => i,
	output=> o);

process
begin
	
	i <= "001";
	wait for 100 ns;
	i <= "000";
	wait for 100 ns;
	i <= "011";
	wait for 100 ns;
	i <= "010";
	wait for 100 ns;
	i <= "101";
	wait for 100 ns;
	i <= "100";
	wait for 100 ns;
	i <= "110";
	wait for 100 ns;
	i <= "111";
	wait;
	
end process;

end testBench;

