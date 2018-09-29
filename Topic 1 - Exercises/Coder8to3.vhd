-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Coder 8to3 desing using VHDL.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Coder8to3 is
	port(input:   in std_logic_vector(7 downto 0);
		  output: out std_logic_vector(2 downto 0));
end Coder8to3;

architecture Behavioral of Coder8to3 is

begin
	-- Generic simpler way?
	
	output <= "111" when input(7)='1' else
				 "110" when input(6)='1' else
				 "101" when input(5)='1' else
				 "100" when input(4)='1' else
				 "011" when input(3)='1' else
				 "010" when input(2)='1' else
				 "001" when input(1)='1' else
			    "000";
	
end Behavioral;

