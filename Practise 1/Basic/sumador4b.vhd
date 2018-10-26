-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise one, part one. VHDL desing for
-- a 4bits adder.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sumador4b is
	port(A, B: in  std_logic_vector(3 downto 0);
		    C: out std_logic_vector(3 downto 0));
		--	i: in  std_logic;  -- Carry input
		--	o: out std_logic); -- Carry output
end sumador4b; 

architecture Behavioral of sumador4b is
-- There is no need to define intermediate signals
begin

	C <= A + B;
	
	-- We don't need a process, it's just pure combinational logic
end Behavioral;

