-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 4 bits comparator designed in VHDL.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparator is
	port(A, B:   in  std_logic_vector(3 downto 0);
		  output: out std_logic);		 
end Comparator;

architecture Behavioral of Comparator is
begin

-- Conditional sentences must be inside a process clause!
process(A, B)
begin
	if(A = B) then output<='1';
	else	         output<='0';
	end if;
end process;

end Behavioral;

