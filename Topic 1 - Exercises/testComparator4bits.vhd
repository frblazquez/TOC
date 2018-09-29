-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Test for the 4 bits comparator designed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testComparator4bits is
end testComparator4bits;

architecture testBench of testComparator4bits is
component Comparator is
	port(A, B:   in  std_logic_vector(3 downto 0);
		  output: out std_logic);		 
end component;

signal i1,i2: std_logic_vector(3 downto 0);
signal o: std_logic;

begin
comparador: Comparator port map(
	A => i1,
	B => i2,
	output => o);
	
process
begin

i1 <= "0000";
i2 <= "0000";
wait for 100 ns;
i1 <= "0000";
i2 <= "1111";
wait for 100 ns;
i1 <= "1111";
i2 <= "0111";
wait for 100 ns;
i1 <= "1011";
i2 <= "1101";
wait for 100 ns;
i1 <= "1010";
i2 <= "1010";
wait for 100 ns;
i1 <= "0011";
i2 <= "0011";
wait;


end process;

end testBench;

