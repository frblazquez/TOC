-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Car washer.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CoinReaderTest is
end CoinReaderTest;

architecture Behavioral of CoinReaderTest is
	
	component CoinReader is
	port(clk:  in std_logic;
		  rst:  in std_logic;
		  coin: in std_logic;
	     coinRead: in  std_logic;
	     numCoins: out std_logic_vector(1 downto 0));
	end component;
	
	signal clk: std_logic;
	signal rst: std_logic;
	signal coin: std_logic;
	signal coinRead: std_logic;
	signal numCoins: std_logic_vector(1 downto 0);
	
	constant clk_time: time := 50 ns;
	constant clk_period: time := 2*clk_time;
	
begin

cr: CoinReader port map
(
	clk      => clk,
	rst      => rst,
	coin     => coin,
	coinRead => coinRead,
	numCoins => numCoins
);

process
begin	

	if(clk='1') then
		clk<='0';
	else
		clk<='1';
	end if;
	
	wait for clk_time;
	
end process;


process
begin

	wait for 75 ns;

	rst <= '1';
	wait for 2*clk_period;
	
	rst <= '0';
	coin <= '0';
	coinRead <= '0';
	wait for 2*clk_period;
	
	coinRead <= '1';
	wait for 2*clk_period;
	
	coin <= '1';
	wait for clk_period;
	
	coin <= '0';	
	wait;
end process;


end Behavioral;

