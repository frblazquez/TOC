-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Desing using VHDL a system that returns
-- value one if the input number is prime, lower than 4 
-- and even or greater than 8 and odd.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SystemEj2 is
	port(input:  in  std_logic_vector(3 downto 0);
		  output: out std_logic);
end SystemEj2;

architecture Behavioral of SystemEj2 is

-- Just for simplicity we use this signals.
signal primo, menor4Par, mayor8Impar: std_logic;

begin
	
	primo <= '1' 		 when input = "0010" or	input = "0011" or
							 	   input = "0101" or	input = "0110" or
							 	   input = "1011" else '0';
	menor4Par <= '1'	 when input = "0000" or input = "0010" else '0';
	mayor8Impar <= '1' when input = "1001" or input = "1011" or 
									input = "1111" else '0';
									
	output <= primo or menor4Par or mayor8Impar;
	
end Behavioral;

