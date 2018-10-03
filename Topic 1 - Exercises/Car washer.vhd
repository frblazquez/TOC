-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: VHDL design for a car washer system.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity carWasher is
	port(clk:       in std_logic;
		  startStop: in std_logic;
		  waxIn:  	 in std_logic;
		  waterOut: out std_logic;
		  airOut: 	out std_logic;
		  waxOut:   out std_logic;
		  rollOut:  out std_logic;
		  soapOut:  out std_logic);
end carWasher;

architecture Behavioral of carWasher is
	type states is (S0,S1,S2,S3,S4);
	
	signal counter: std_logic := '0';
	signal state: 		 states := S0;
	signal nextState:	 states := S0;
begin
	
	-- Process to manage the change of state synchronously
	process(clk, startStop)
	begin
		if(startStop = '0') then
		state <= S0;
		elsif(clk'event and clk='1') then
		state <= nextState;
		end if;
	end process;
	
	-- If this process could change the 'State' value, we
	-- could have an infinite loop in the simulation.
	--
	-- startStop is not in this process sensibility list, we
	-- just let him to decide about the next state, never 
	-- about the actual state.
	process(state, waxIn)
	begin
	
	waterOut <= '0';	airOut	<= '0';
	waxOut   <= '0';	rollOut  <= '0';
	soapOut  <= '0';  nextState<= state;
	
	case state is
	when S0 =>	nextState <= S1; 
	when S1 =>  nextState <= S2; 
					soapOut   <= '1';
	when S2 =>  rollOut   <= '1';
		-- Does it have to repeat?
		if counter='1' then 
			nextState <= S3;
			counter<='0';
		else
			counter<='1';
		end if;
	when s3 =>	waterOut <= '1';
		if waxIn='1' then nextState <= S4;
		else   				nextState <= S0;
		end if;
	when others => waxOut <= '1'; nextState <= S0;
	end case;
	
	
	end process;
	

end Behavioral;

