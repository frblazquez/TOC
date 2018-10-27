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

entity TestbenchMul is
end TestbenchMul;

architecture Behavioral of TestbenchMul is
	
	-- Components we are going to test:
	component MultiplierStd
	port(A: in  std_logic_vector(3 downto 0);
		  B: in  std_logic_vector(3 downto 0);
		  Z: out std_logic_vector(7 downto 0));
	end component;
	
	component MultiplierAdders
	port(A: in  std_logic_vector(3 downto 0);
		  B: in  std_logic_vector(3 downto 0);
		  Z: out std_logic_vector(7 downto 0));
	end component;
	
	-- Signals needed (input):
	signal A: std_logic_vector(3 downto 0) := (others=>'0');
	signal B: std_logic_vector(3 downto 0) := (others=>'0');
	
	-- Signals needed (output):
	signal Zadd: std_logic_vector(7 downto 0);
	signal zstd: std_logic_vector(7 downto 0);
	
begin
	
	mulAdd: MultiplierAdders port map
	(
		A => A,
		B => B,
		Z => Zadd
	);
	
	mulStd: MultiplierStd port map
	(
		A => A,
		B => B,
		Z => Zstd	
	);
	
	-- Test cases:
	process
	begin
	
	A <= "0000";
	B <= "0000";
	wait for 100 ns;
	
	A <= "0001";
	B <= "0001";
	wait for 100 ns;
	
	A <= "0001";
	B <= "0010";
	wait for 100 ns;
	
	A <= "0001";
	B <= "1000";
	wait for 100 ns;
	
	A <= "1000";
	B <= "0010";
	wait for 100 ns;
	
	A <= "1010";
	B <= "0101";
	wait for 100 ns;
	
	A <= "1111";
	B <= "1111";
	wait for 100 ns;
	
	wait;
	
	end process;

end Behavioral;

