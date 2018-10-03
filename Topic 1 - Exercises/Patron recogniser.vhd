-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Desing a patron "0011" recogniser.

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity Exercise5 is
	port(clk, X: in  std_logic;
		       Z: out std_logic);
end Exercise5;

architecture Behavioral of Exercise5 is
	-- We define our types for the states
	type states is (S0, S1, S2, S3);
	
	-- Signals we are going to need
	signal State:     states := S0;
	signal nextState: states := S0;
	
begin
	
	-- This proces makes the change of state synchronously
	process (clk)
	begin
		if(clk'event and clk='1') then
			State <= nextState;
		end if;	
	end process;
	

	-- The next state and the output depends on X and the actual state
	process (X, State)
	begin
	
	Z <= '0';
	nextState <= State;
	
	case State is
	when S0 => 
		if X='0' then 	nextState <= S1;
		end if;
		
	when S1 => 
		if X='0' then	nextState <= S2;
		else 			nextState <= S0;
		end if;
		
	when S2 =>  
		if X='1' then 	nextState <= S3;
		end if;
		
	when others => 
		if X='1' then  nextState <= S0; Z <= '1';
		else 		   nextState <= S1;
		end if;
	end case;
	
	-- Why not? Why the process?	
	--
	--	nextState <= S0 when conditions_1;
	--				 S1 when conditions_2;
	--				 S2 when conditions_3;
	--				 S3 when others;
	--
	-- 		Z	<= '1' when State=S3 and X='1';
	--		  	   '0' when others;
	-- 
	-- If we don't use a process, we could create
	-- an infinite loop in the simulation.
	-- The change of this variables in the sensibility list
	-- affect themselves, but this doesn't mean that the state
	-- is not stable.
	end process;
end Behavioral;

