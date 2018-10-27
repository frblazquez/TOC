-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- 4bit multiplier using '*' operator in numeric_std.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MultiplierStd is
	port(A: in  std_logic_vector(3 downto 0);
		  B: in  std_logic_vector(3 downto 0);
		  Z: out std_logic_vector(7 downto 0));
end MultiplierStd;

architecture Behavioral of MultiplierStd is

begin
	
	-- Why doesn't the synthesizer complain about this?
	-- I'm ordering a 8 bit vector to be a 2 4 unsigned vector product
	--
	-- If you change Z length increasing or decreasing it you'll receive
	-- a synthesis error. 
	--
	-- Conclusion: 4x4 unsigned expectes to be an 8 unsigned
	Z <= std_logic_vector(unsigned(A) * unsigned(B));

end Behavioral;

