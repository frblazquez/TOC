-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Patron "111" and "000" recogniser.

library IEEE;
use IEEE.STd_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.All;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity patronAAA is
	port(clk, X: in  std_logic;
		       Z: out std_logic);
end patronAAA;

architecture Behavioral of patronAAA is
	type states is (S0,S1);
	
   signal elem:      std_logic := '0';
	signal state:     states := S0;
	signal nextState: states := S0;
begin

process(clk)
begin
	if clk'event and clk='1' then
		state <= nextState;
	end if;
end process;

process(state, X)
begin
	Z <= '0'; nextState <= state;
	
	if state=S0 then
		if elem=X then  nextState <= S1;
		else elem <= X; end if;
	else
		if elem=X then Z <= '1';
		else elem <= X; nextState <= S0; end if;
	end if;
end process;

end Behavioral;

