-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Thorough test involving all possible combinations.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ExhaustiveTest is
end ExhaustiveTest;

architecture Behavioral of ExhaustiveTest is

	-- Components we are testing
	component sumador8bInteger
	port( ci: in  std_logic;
			A:  in  std_logic_vector(7 downto 0);
			B:  in  std_logic_vector(7 downto 0);
		   Z:  out std_logic_vector(7 downto 0);
			co: out std_logic);
	end component;
	
	component sumador8bUnsigned
	port( ci: in  std_logic;
			A:  in  std_logic_vector(7 downto 0);
			B:  in  std_logic_vector(7 downto 0);
		   Z:  out std_logic_vector(7 downto 0);
			co: out std_logic);
	end component;
	
	-- Signals needed (input):
	signal ci: std_logic := '0';
	signal  A: std_logic_vector(7 downto 0) := (others=>'0');
	signal  B: std_logic_vector(7 downto 0) := (others=>'0');
	
	-- Signals needed (output):
	signal coInt: std_logic;							-- Overflow for integer adder
	signal coUns: std_logic;							-- Overflow for unsigned adder
	signal Zint:  std_logic_vector(7 downto 0);	-- Output for integer adder
	signal Zuns:  std_logic_vector(7 downto 0);	-- Output for unsigned adder
	
	-- Signals expected:
	signal Zexpected: std_logic_vector(8 downto 0);
	
begin

	sumInteger: sumador8bInteger port map
	(
		ci => ci,
		A  => A,
		B  => B,
		Z  => Zint,
		co => coInt
	);
	
	sumUnsigned: sumador8bUnsigned port map
	(
		ci => ci,
		A  => A,
		B  => B,
		Z  => Zuns,
		co => coUns
	);
	
	-- Tests checking the result:
	process
		-- Loop control variables
		variable i: natural := 0;
		variable j: natural := 0;
	begin
	
	ci <= '0';

	A_range: for i in 0 to 255 loop
	B_range: for j in 0 to 255 loop
	
		A <= std_logic_vector(to_unsigned(i,8));
		B <= std_logic_vector(to_unsigned(j,8));
		Zexpected <= std_logic_vector(to_unsigned(i+j,9));
		wait for 10 ns; -- To get the result
		
		assert Zexpected(8)=coInt and Zexpected(7 downto 0)=Zint
			report "The adder using integer functions fails"
			severity error;
		
		assert Zexpected(8)=coUns and Zexpected(7 downto 0)=Zuns
			report "The adder using unsigned functions fails"
			severity error;
		
		wait for 10 ns;
		
	end loop B_range;
	end loop A_range;
	
	
	ci <= '1';
	i  := 0;
	j  := 0;

	A2_range: for i in 0 to 255 loop
	B2_range: for j in 0 to 255 loop
	
		A <= std_logic_vector(to_unsigned(i,8));
		B <= std_logic_vector(to_unsigned(j,8));
		Zexpected <= std_logic_vector(to_unsigned(i+j+1,9));
		wait for 10 ns; -- To get the result
		
		assert Zexpected(8)=coInt and Zexpected(7 downto 0)=Zint
			report "The adder using integer functions fails"
			severity error;
		
		assert Zexpected(8)=coUns and Zexpected(7 downto 0)=Zuns
			report "The adder using unsigned functions fails"
			severity error;
		
		wait for 10 ns;
		
	end loop B2_range;
	end loop A2_range;
	
	wait; -- We don't want infinite loops
	
	end process;

end Behavioral;