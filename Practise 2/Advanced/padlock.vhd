-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: VHDL design for an digital padlock.

library IEEE;use IEEE.STD_LOGIC_1164.ALL; use IEEE.STD_LOGIC_ARITH.All;use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity padlock is
	port(rst:             in std_logic;
		  clk:             in std_logic;
		  keyAttempts:     in std_logic_vector(3 downto 0);
		  keyCombination:  in std_logic_vector(7 downto 0);
		  isUnlocked:     out std_logic;
		  lockedForever:  out std_logic;
		  attemptsLeft:   out std_logic_vector(3 downto 0));
end padlock;

architecture Behavioral of padlock is
	-- States allowed
	type states is (Si, S1, Sf);
	
	-- Attemts we let to find out our key
	-- constant INTENTOS: std_logic_vector(3 downto 0) := "0011";
	
	signal actualState: states := Si;
	signal nextState:   states := Si;
	signal storedAttemptsLimit:  std_logic_vector(3 downto 0);
	signal nextKeyAttemptsLimit: std_logic_vector(3 downto 0);
	signal storedKey: std_logic_vector(7 downto 0);
	signal nextKey:   std_logic_vector(7 downto 0);
	signal isLockedForever: std_logic;
	
begin
	
	attemptsLeft <= storedAttemptsLimit;
	lockedForever <= isLockedForever;
	
	process(rst, clk)
	begin
	
		if(rst='0') then
			actualState <= Si;
		elsif(clk'event and clk='1') then
			actualState 			<= nextState;
			storedKey   			<= nextKey;
			storedAttemptsLimit 	<= nextKeyAttemptsLimit;
		end if;
	
	end process;
	
	process(actualState, keyCombination)
	begin
		-- Default output values
		isUnlocked 	 			<= '0';
		nextState   		 	<= Si;  
		nextKey      			<= storedKey;
		nextKeyAttemptsLimit <= "0000";
		isLockedForever 			<= '0';
		              
		-- Depending the actualState
		case actualState is
		when Si => 
			nextState    			<= S1;
			nextKey      			<= keyCombination;
			nextKeyAttemptsLimit <= keyAttempts;
			isUnlocked   			<= '1';
			
		when S1 => 
			if(keyCombination /= storedKey) then
				if(storedAttemptsLimit = "0000") then
					nextState <= Sf;
				else
					nextKeyAttemptsLimit <= storedAttemptsLimit - "0001";
					nextState <= S1;
				end if;
			end if;
			
		when others =>
			nextState <= Sf;
			isLockedForever <= '1';
		end case;
		
	end process;

end Behavioral;

