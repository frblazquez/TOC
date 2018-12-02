-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Counter from 0 to 9.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CounterMod10 is
	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
	     clk:  in  std_logic;								-- Clock signal
		  count:in  std_logic;								-- Count bit
		  c_out:out std_logic_vector(3 downto 0));	-- Counter state
end CounterMod10;

architecture Behavioral of CounterMod10 is
	
	-- Up limit for the counter:
	constant limit: unsigned(3 downto 0) := "1010"; -- 10 (binary)
	
	-- Counter signal:
	signal counter: unsigned(3 downto 0) := "0000";
	
begin

	process(clk, counter)
	begin

		if(rising_edge(clk)) then
			if(rst='1') then
				counter <= "0000";
			elsif(count='1') then
				counter <= counter+1;
			end if;
		end if;
		
		if(counter=limit) then
			counter <= "0000";
		end if;
	
	end process;
	
	c_out <= std_logic_vector(counter);
	
end Behavioral;


-- FAST COPY FOR USUAL SCHEMAS:
--
--component CounterMod10
--	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
--	     clk:  in  std_logic;								-- Clock signal
--		  count:in  std_logic;								-- Count bit
--		  c_out:out std_logic_vector(3 downto 0));	-- Counter state
--end component;
--
--:CounterMod10 
-- port map
--(
--		rst => ,
--		clk => ,
--		count => ,
--		c_out=> 
--);
