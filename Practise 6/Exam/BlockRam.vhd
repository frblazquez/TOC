-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- BlockRam memory for MIPS processor. Initialization inside the memory.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity BlockRam is
port( clka, wea, ena : in std_logic;
		addra : in  std_logic_vector(8  downto 0);
		dina  : in  std_logic_vector(31 downto 0);
		douta : out std_logic_vector(31 downto 0));
end BlockRam;

architecture Behavioral of BlockRam is

	type ram_type is array (0 to 511) of std_logic_vector (31 downto 0);
	signal ram : ram_type := 
	(
x"40030000",
x"48640000",
x"40050004",
x"44000000",
x"44010001",
x"40020001",
x"10A40007",
x"00223024",
x"10C40001",
x"00601820",
x"00000002",
x"00200800",
x"00A22822",
x"08000014",
x"AC830040",
x"0800003C",
others => x"00000000");

begin

	process( clka )
	begin
		if clka'event and clka = '1' then
			if ena = '1' then
				if wea = '1' then
					ram(to_integer(unsigned(addra))) <= dina;
					douta <= dina;
				else
					douta <= ram(to_integer(unsigned(addra)));
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

