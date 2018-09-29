-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 4 bits vectorial xor desing at VHDL.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Xor4bits is
	port(A, B:  in  std_logic_vector(3 downto 0);
		    C: out std_logic_vector(3 downto 0));
end Xor4bits;
 
architecture Behavioral of Xor4bits is

begin
	C <= A xor B;

end Behavioral;
