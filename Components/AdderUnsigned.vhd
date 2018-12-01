-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Practise three, part one. VHDL desing for a 8bits adder.
-- This architecture implementation uses numeric_std functions
-- to operate with UNSIGNED elements.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sumador8bUnsigned is
	port( ci: in  std_logic;
			A:  in  std_logic_vector(7 downto 0);
			B:  in  std_logic_vector(7 downto 0);
		   Z:  out std_logic_vector(7 downto 0);
			co: out std_logic);
end sumador8bUnsigned; 

architecture Behavioral of sumador8bUnsigned is

-- We don't want to lose our carry out bit
signal Aextended: unsigned(8 downto 0);
signal Bextended: unsigned(8 downto 0);
signal Zextended: unsigned(8 downto 0);
signal cinAsVector: std_logic_vector(0 downto 0);

begin

-- Single bit as vector (for next cast)
cinAsVector(0) <= ci;

-- A as an 8 bit vector (for keeping the overflow)
Aextended(7 downto 0) <= unsigned(A);
Aextended(8) <= '0';

-- B as an 8 bit vector
Bextended(7 downto 0) <= unsigned(B);
Bextended(8) <= '0';

-- Now we operate with unsigned elements (thanks to numeric_std)
Zextended <= Aextended + Bextended + unsigned(cinAsVector);

-- We cast-back to get our coveted bits
co <= Zextended(8); -- std_logic <= unsigned bit!! TEST!!
Z  <= std_logic_vector(Zextended(7 downto 0));

end Behavioral;