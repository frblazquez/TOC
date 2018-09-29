-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 4to1 Multiplexor designed test.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity testMux4to1 is
end testMux4to1;

architecture testBench of testMux4to1 is
-- Componente que vamos a testear
component Mux4to1 is
	port(input:   in std_logic_vector(3 downto 0);
	     control: in std_logic_vector(1 downto 0);
		  output:  out std_logic);
end component;

-- Señales de entrada/salida al componente
signal input: 	 std_logic_vector(3 downto 0);
signal control: std_logic_vector(1 downto 0);
signal output:  std_logic;

begin

multiplexor: Mux4to1 port map(
	input   => input,
	control => control,
	output  => output);
	
process
begin

input <= "0000";
control <= "00";
-- expected: output = "0"
wait for 100 ns;

input <= "0001";
-- expected: output = "1"
wait for 100 ns;

input <= "0000";
control <= "01";
-- expected: output = "0"
wait for 100 ns;

input <= "0010";
control <= "01";
-- expected: output = "1"
wait for 100 ns;

input <= "0111";
control <= "11";
-- expected: salida = "0"
wait for 100 ns;

input <= "1011";
control <= "10";
-- expected: salida = "0"
wait;
end process;

end testBench;

