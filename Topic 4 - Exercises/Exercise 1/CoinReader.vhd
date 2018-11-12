-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Coin reader.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CoinReader is
port(clk:  in std_logic;
	  rst:  in std_logic;
	  coin: in std_logic;
	  coinRead: in  std_logic;
	  numCoins: out std_logic_vector(1 downto 0));
end CoinReader;

architecture Behavioral of CoinReader is

signal actCoins: std_logic_vector(1 downto 0) := "00";
signal nxtCoins: std_logic_vector(1 downto 0) := "00";

begin

-- numCoins is the value of actCoins
numCoins <= actCoins;

-- nxtCoins is a combinational function of 
-- signals placed in when clauses.
nxtCoins <= "00"     when rst='1'       else
				actCoins when coinRead='0'  else
				actCoins when coin='0'      else
				"01"     when actCoins="00" else
				"10"     when actCoins="01" else
				actCoins;

process(clk)
begin

	if(clk'event and clk='1') then
		actCoins <= nxtCoins;
	end if;

end process;

end Behavioral;

