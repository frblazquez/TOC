-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem2 is
port (clk : in STD_LOGIC;
		we:   in STD_LOGIC;
		en :  in STD_LOGIC;
		addr: in STD_LOGIC_VECTOR (3 downto 0);
		di :  in STD_LOGIC_VECTOR (3 downto 0);
		do : out STD_LOGIC_VECTOR (3 downto 0));
end mem2;


architecture Behavioral of mem2 is

type ram_type is array (0 to 15) of std_logic_vector(3 downto 0);
signal ram : ram_type:= ("0000", "0110", "0111", "1000", "1001", "0101", 
"0001", "0010", "0011", "1000", "0000", "0000", "0000", "0000", "0000", "0000"); 

begin

process (clk)
begin

if clk'event and clk = '1' then
	if en = '1' then
		do <= ram(to_integer(unsigned((addr))));
		
		if we = '1' then
			ram(to_integer((unsigned(addr)))) <= di;
		end if;
	end if;
end if;

end process;

end Behavioral;