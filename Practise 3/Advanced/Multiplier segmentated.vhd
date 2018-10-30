-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- 4bit multiplier design using 8bit adders in cascade.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MultiplierAdders is
	port(clk: in  std_logic;
		  rst: in  std_logic;
		  A:   in  std_logic_vector(3 downto 0);
		  B:   in  std_logic_vector(3 downto 0);
		  Z:   out std_logic_vector(7 downto 0));
end MultiplierAdders;

architecture Behavioral of MultiplierAdders is
	
	-- 8 bit adder (previously tested)
	component sumador8bInteger
	port( ci: in  std_logic;
			A:  in  std_logic_vector(7 downto 0);
			B:  in  std_logic_vector(7 downto 0);
		   Z:  out std_logic_vector(7 downto 0);
			co: out std_logic);
	end component; 
	
	-- Signals needed:
	signal A1,A2,A3,A4: std_logic_vector(7 downto 0) := (others=>'0');
	signal B1,B2,B3,B4: std_logic_vector(3 downto 0);
	signal Z1,Z2: 	     std_logic_vector(7 downto 0);
	
	signal reg1Out: std_logic_vector(7 downto 0) := (others=>'0');
	signal reg2Out: std_logic_vector(7 downto 0) := (others=>'0');
	
begin
	
	-- Clock signal and next state for the register outputs
	process(clk,rst)
	begin
	
		if(clk'event and clk='1') then
			if(rst='0') then
				reg1Out <= (others =>'0');
				reg2Out <= (others =>'0');
			else 
				reg1Out <= Z1;
				reg2Out <= Z2;			
			end if;
		end if;
	
	end process;
	
	
	-- This botch is because we can't do A and B(i).
	-- We can't do std_logic_vector and std_logic so
	-- we have to extend our bit to a vector
	B1 <= (others=>B(0));
	B2 <= (others=>B(1));
	B3 <= (others=>B(2));
	B4 <= (others=>B(3));
	
	A1(3 downto 0) <= A and B1;
	A2(4 downto 1) <= A and B2;
	A3(5 downto 2) <= A and B3;
	A4(6 downto 3) <= A and B4;
	
	
	Adder1: sumador8bInteger port map
	(
		ci => '0',
		A  => A1,
		B  => A2,
		Z  => Z1
	-- co => don't care!
	);
	
	Adder2: sumador8bInteger port map
	(
		ci => '0',
		A  => A3,
		B  => A4,
		Z  => Z2
	-- co => don't care!
	);
	
	Adder3: sumador8bInteger port map
	(
		ci => '0',
		A  => reg1Out,
		B  => reg2Out,
		Z  => Z
	-- co => don't care!
	);

end Behavioral;
