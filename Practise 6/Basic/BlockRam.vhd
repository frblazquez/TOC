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
x"40030000",--				mv  R3, #0	 	 0x00000000	010000 ----- 00011 0000000000000000
x"48640000",-- 			mv  R4, R3	 	 0x00000004	010010 00011 00100 ----------------		
x"44000000",--				lsw  R0 ext	 	 0x00000008	010001 ----- 00000 0000000000000000
x"44010001",--				lsw  R1 sup  	 0x0000000C	010001 ----- 00001 0000000000000001
x"40020001",--				mv  R2, #1	 	 0x00000010	010000 ----- 00010 0000000000000001
x"10240003",-- WHILE:	beq R1, R4, FIN 0x00000014	000100 00001 00100 0000000000000011
x"00601820",-- 			add R3, R3, R0	 0x00000018	000000 00011 00000 00011 00000 100000
x"00220822",-- 			sub R1, R1, R2	 0x0000001C	000000 00001 00010 00001 00000 100010
x"08000014",-- 			j   WHILE		 0x00000020	000010 00000000000000000000010100
x"AC83002C",-- FIN: 		sw  R3 C	 		 0x00000024	101011 00100 00011 0000000000101100
x"08000028",-- FINAL:	j   FINAL		 0x00000028	000010 00000000000000000000101000
				--  			VALOR C = A*B	 0x0000002C
others => x"00000000"
	);

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

