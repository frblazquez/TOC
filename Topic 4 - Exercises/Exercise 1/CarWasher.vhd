-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Car washer.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CarWasher is
port(clk:  in std_logic;		-- Synchronous transitions
	  rst:  in std_logic;		-- Back to initial state
	  init: in std_logic;		-- Starts the coins lecture
	  coin: in std_logic;		-- Another coin came
	  wash: in std_logic;		-- Starts the wash
	  Wend: in std_logic;		-- Signal to end the water flow
	  Send: in std_logic;		-- Signal to end the soap flow
	  water:  out std_logic;	-- Activates the water
	  soap:   out std_logic;	-- Activates the soap
	  finish: out std_logic);  -- The wash has finished
end CarWasher;

architecture Behavioral of CarWasher is

	component Controller
	port(clk:   in std_logic;		
		  rst:   in std_logic;		
		  init:  in std_logic;		
		  wash:  in std_logic;		
		  Wend:  in std_logic;		
		  Send:  in std_logic;		
		  coins: in std_logic_vector(1 downto 0);
	     coinRead: out std_logic;
		  coinRst:  out std_logic;
		  water:    out std_logic;	
		  soap:     out std_logic;	
		  finish:   out std_logic);	  
	end component;
	
	component DataPath
	port(clk:  in std_logic;
		  rst:  in std_logic;
		  coin: in std_logic;
		  coinRead:   in std_logic;
		  coinsCode: out std_logic_vector(1 downto 0));
	end component;
	
	signal coins:    std_logic_vector(1 downto 0);
	signal coinRst:  std_logic;
	signal coinRead: std_logic;
	
begin

Control: Controller port map
(
	clk      => clk,
	rst      => rst,
	init     => init,		
   wash     => wash,		
   Wend     => Wend,
   Send     =>	Send,
   coins    => coins,
   coinRead => coinRead,
   coinRst  => coinRst,
   water    =>	water,
   soap     =>	soap,
   finish   =>	finish
);

Data: DataPath port map
(
	clk       => clk,
	rst       => coinRst,
	coin      => coin,
	coinRead  => coinRead,
	coinsCode => coins
); 

end Behavioral;

