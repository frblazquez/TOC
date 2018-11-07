-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Multiplier designed from and ASM diagram.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MultiplierASM is
	port(rst: in  std_logic;
		  clk: in  std_logic;
		  ini: in  std_logic;
		  A:   in  std_logic_vector(3 downto 0);
		  B:   in  std_logic_vector(3 downto 0);
		  Z:   out std_logic_vector(7 downto 0);
		  fin: out std_logic);
end MultiplierASM;

architecture Behavioral of MultiplierASM is
	
	-- n bits register
	component register_n
		generic (n: natural := 8);
		port (clk: in std_logic;
				rst: in std_logic;
				load: in std_logic;
				din: in std_logic_vector(n-1 downto 0);
				dout: out std_logic_vector(n-1 downto 0));
	end component;

begin


end Behavioral;

