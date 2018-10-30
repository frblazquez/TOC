-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Practise three, part one. VHDL desing for a 8bits adder.
-- This architecture implementation uses numeric_std functions
-- to operate with INTEGER elements.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sumador8bInteger is
	port( ci: in  std_logic;
			A:  in  std_logic_vector(7 downto 0);
			B:  in  std_logic_vector(7 downto 0);
		   Z:  out std_logic_vector(7 downto 0);
			co: out std_logic);
end sumador8bInteger; 

architecture Behavioral of sumador8bInteger is

-- We are going to operate with integers and then cast
signal Aint     : integer;
signal Bint     : integer;
signal Zint     : integer;
signal Carryint : integer;

signal Carryslv : std_logic_vector(0 downto 0);
signal Zextended: std_logic_vector(8 downto 0);

begin

-- std_logic to std_logic_vector
Carryslv(0) <= ci;

-- Everything to integer!
Aint      <= to_integer(unsigned(A));
Bint      <= to_integer(unsigned(B));
Carryint  <= to_integer(unsigned(Carryslv));

-- We operate with our integer values
Zint      <= Aint + Bint + Carryint;

-- We cast-back to std_logic and std_logic_vector
Zextended <= std_logic_vector(to_unsigned(Zint,9));

-- Assign the result to our output
co <= Zextended(8);
Z  <= Zextended(7 downto 0);

end Behavioral;
