-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Data path for the ASM multiplier.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dataPath is
	port (clk:     in  std_logic;
			reset:   in  std_logic;
			a_in:    in  std_logic_vector(7 downto 0);
			b_in:    in  std_logic_vector(7 downto 0);
			control: in  std_logic_vector (4 downto 0);
			zero:    out std_logic;
			result:  out std_logic_vector (7 downto 0));
end dataPath;

architecture Behavioral of dataPath is

begin


end Behavioral;

