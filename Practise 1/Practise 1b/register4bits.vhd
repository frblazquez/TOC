-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise one, part two. VHDL desing for a
-- 4 bits parallel regiter.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register4bits is
	port(rst, clk, load: std_logic;
		  I: in  std_logic_vector(3 downto 0);
		  O: out std_logic_vector(3 downto 0));
end register4bits;

architecture Behavioral of register4bits is
begin  

process(clk, rst)
begin
	-- We let the reset signal to be asynchronous.
	if rst='1' 
		then O <= (others => '0');
	elsif clk'event and clk='1' then 
		if load='1'	then O <= I;
		end if;
	end if;
end process;

end Behavioral;

