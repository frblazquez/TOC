-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Data path.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataPath is
port(clk:  in std_logic;
	  rst:  in std_logic;
	  coin: in std_logic;
	  coinRead:  in  std_logic;
	  coinsCode: out std_logic_vector(1 downto 0));
end DataPath;

architecture Behavioral of DataPath is

component CoinReader
port(clk:  in std_logic;
	  rst:  in std_logic;
	  coin: in std_logic;
	  coinRead: in  std_logic;
	  numCoins: out std_logic_vector(1 downto 0));
end component;

begin

CR: CoinReader port map
(
	clk => clk,
	rst => rst,
	coinRead => coinRead,
	coin => coin,
	numCoins => coinsCode
);

end Behavioral;

