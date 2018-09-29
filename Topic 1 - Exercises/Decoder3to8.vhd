-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Desing of a 3to8 decoder in VHDL.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- to_integer()!!
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decoder3to8 is
	port(input:  in  std_logic_vector(2 downto 0);
		 output: out std_logic_vector(7 downto 0));
end Decoder3to8;

architecture Behavioral of Decoder3to8 is

begin

-- We can't do this, just remember how the simulation in
-- VHDL is executed. Maybe inside a process?
--
--	output(to_integer(unsigned(input))) <= '1';
--	output <= (others => '0');
	
with input select
output <= "00000001" when "000",
			 "00000010" when "001",
			 "00000100" when "010",
			 "00001000" when "011",
			 "00010000" when "100",
			 "00100000" when "101",
			 "01000000" when "110",
			 "10000000" when others;
	
end Behavioral;

