-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 4to1 Multiplexor desing in VHDL

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux4to1 is
	port(input:   in std_logic_vector(3 downto 0);
	     control: in std_logic_vector(1 downto 0);
		  output:  out std_logic);
end Mux4to1;

architecture mux_arch of Mux4to1 is

begin
	
	-- output <= input(to_integer(control));
	
	-- Tedious way for doing it, choosing cases:
	 with control select
	 output <= input(0) when "00",
				  input(1) when "01",
				  input(2) when "10",
				  input(3) when others;

end mux_arch;

