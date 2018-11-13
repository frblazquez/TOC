-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for 4x4bit multiplier designed from an ASM description.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TestbenchMul is
end TestbenchMul;

architecture Behavioral of TestbenchMul is
	
	-- Components we are going to test:
	component MultiplierASM is
	port(rst: in  std_logic;
		  clk: in  std_logic;
		  ini: in  std_logic;
		  A:   in  std_logic_vector(3 downto 0);
		  B:   in  std_logic_vector(3 downto 0);
		  Z:   out std_logic_vector(7 downto 0);
		  fin: out std_logic);
	end component;
	
	-- Signals needed (input):
	signal rst: std_logic := '0';
	signal clk: std_logic := '0';
	signal ini: std_logic := '0';
	signal A: std_logic_vector(3 downto 0) := (others=>'0');
	signal B: std_logic_vector(3 downto 0) := (others=>'0');
	
	-- Signals needed (output):
	signal Z: std_logic_vector(7 downto 0);
	signal fin: std_logic; 
begin
	
	mul: MultiplierASM port map
	(
		rst => rst,
		clk => clk,
		ini => ini,
		A   => A,
		B   => B,
		Z   => Z,
		fin => fin
	);
	
	process
	begin
			
		if(clk='1') then 
			clk<='0';
		else
			clk<='1';
		end if;
		
		wait for 30 ns;
		
	end process;
	
	
	-- Test cases:
	process
	begin
	
	rst <= '1';
	wait for 200 ns;
	
	rst <= '0';
	ini <= '1';
	wait for 60 ns;
	
	A <= "0000";
	B <= "0000";
	wait for 2000 ns; 
	
	A <= "0001";
	B <= "0001";
	wait for 2000 ns;
	
	A <= "0001"; 
	B <= "0010";
	wait for 2000 ns;
	
	A <= "0001";
	B <= "1000";
	wait for 2000 ns;
	
	A <= "1000";
	B <= "0010";
	wait for 2000 ns;
	
	A <= "1010";
	B <= "0101";
	wait for 2000 ns;
	
	A <= "1111";
	B <= "1111";
	wait for 2000 ns;
	
	wait;
	
	end process;

end Behavioral;

