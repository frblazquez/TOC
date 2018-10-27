-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for both adders designed using numeric_std functions.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TestbenchAdders is
end TestbenchAdders;

architecture Behavioral of TestbenchAdders is

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
	
	-- Simulation:
	process
	begin
	
		wait for 100 ns;
		
		A  <= "00000001";
		B  <= "00000000";
		ci <= '0';
		wait for 100 ns;
		
		A  <= "00000001";
		B  <= "00000000";
		ci <= '1';
		wait for 100 ns;
		
		A  <= "01010101";
		B  <= "10101010";
		ci <= '0';
		wait for 100 ns;
	
		A  <= "01010101";
		B  <= "10101010";
		ci <= '1';
		wait for 100 ns;
		
		A  <= "00000001";
		B  <= "11111111";
		ci <= '0';
		wait for 100 ns;
		
		A  <= "11111111";
		B  <= "00000001";
		ci <= '0';
		wait for 100 ns;
		
		A  <= "11111111";
		B  <= "00000001";
		ci <= '1';
		wait for 100 ns;
		
		wait;
	
	end process;

end Behavioral;

-- At this point everything works OK, however and exhaustive test could 
-- be the definitive proof of correction.