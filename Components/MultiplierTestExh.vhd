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

entity multExhTest is
end multExhTest;

architecture Behavioral of multExhTest is
	
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
	signal Zstd: std_logic_vector(7 downto 0);
	signal Zexpected : std_logic_vector(7 downto 0);

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
	
	-- All test cases:
	process 
		variable i: natural := 0;
		variable j: natural := 0;
	begin
	
	A_range: for i in 0 to 15 loop
	B_range: for j in 0 to 15 loop
		
		A         <= std_logic_vector(to_unsigned(i,4));
		B         <= std_logic_vector(to_unsigned(j,4));
		Zexpected <= std_logic_vector(to_unsigned(i*j,8));
		wait for 10 ns; --Calculate the result 
		
		assert Zadd = 	Zexpected
		report "The adder-implemented multiplier fails"
		severity error;
		
		assert Zstd = Zexpected
		report "The numeric_std-implemented multiplier fails"
		severity error;
		
		wait for 10 ns;
	
	end loop B_range;
	end loop A_range;
	
	wait; -- Stop infinite process loop
	
	end process;
	

end Behavioral;

