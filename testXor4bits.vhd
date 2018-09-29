-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Test for the designed 4 bits xor.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;


entity testXor4bits is
end testXor4bits;


architecture testBench of testXor4bits is

-- Component we are testing
component Xor4bits
	port(A, B: in  std_logic_vector(3 downto 0);
		     C: out std_logic_vector(3 downto 0));
end component;

-- Input/output signals needed
signal op1 : 	std_logic_vector(3 downto 0);
signal op2 : 	std_logic_vector(3 downto 0);
signal result:	std_logic_vector(3 downto 0);

begin
-- Instanciate the component
elemento: Xor4bits port map (
	A => op1,
	B => op2,
	C => result);

process
begin
	op1 <= "0000";
	op2 <= "0000";
	-- expected: result = "0000"
	wait for 100 ns;
	
	op2 <= "1111";
	-- expected: result = "1111"
	wait for 100 ns;
	
	op1 <= "0101";
 	-- expected: result = "1010"
	wait for 100 ns;
	
	op2 <= "1010";
	-- expected: result = "1111"
	wait for 100 ns;
	
	op1 <= "1100";
	-- expected: result = "0110"
	wait;
	
end process;

end testBench;

