-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- VHDL implementation of Topic 4 - Exercise 1. Controller.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controller is
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
end Controller; 

architecture Behavioral of Controller is

type State is (S0,S1,S2,S3);
signal actualState: State := S0;
signal nextState:   State := S0;

begin

process(clk)
begin

	if(clk'event and clk='1') then
		if(rst='1') then
			actualState <= S0;
		else
			actualState <= nextState;
		end if;
	end if;

end process;

process(actualState,init,wash,coins,Wend,Send)
begin

	nextState <= S0;
	finish    <= '0';
	water     <= '0';
	soap      <= '0';
	coinRead  <= '0';
	coinRst   <= '0';
	
case actualState is
when S0 =>

	finish  <= '1';
	coinRst <= '1';
	
	if(init='1') then 
		nextState <= S1;
	end if;

when S1 =>
	
	coinRead <= '1';
	
	if(wash='1') then
		if(coins="00") then
			nextState <= S0;
		else
			nextState <= S2;
		end if;
	else
		   nextState <= S1;
	end if;


when S2 =>

	water <= '1';
	
	if(Wend='1') then
		if(coins(1)='1') then
			nextState <= S3;
		else
			nextState <= S0;
		end if;
	else
		   nextState <= S2;
	end if;
	
when others =>

	soap <= '1';
	
	if(Send='0') then
		nextState <= S3;
	end if;

end case;

end process;


end Behavioral;

