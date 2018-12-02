-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic width counter with parallel load and reset.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CounterNBits is
	generic(N: natural := 4);								-- Counter width
	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
	     clk:  in  std_logic;								-- Clock signal
		  load: in  std_logic;								-- Load control bit
		  count:in  std_logic;								-- Count bit
		  c_in: in  std_logic_vector(N-1 downto 0);	-- Parallel load bits
		  c_out:out std_logic_vector(N-1 downto 0));	-- Counter state
end CounterNBits;

architecture Behavioral of CounterNBits is
	
	signal counter: unsigned(N-1 downto 0);
	
begin

	process(clk)
	begin
		
		-- There is no latches generation in this component synthesis even though
		-- there isn't else clause in this if (neither in the inside if). This is
		-- because every transition is done in rising_edge(clk) signal.
		if(rising_edge(clk)) then
			if(rst='1') then
				counter <= (others => '0');
			elsif(load='1') then
				counter <= unsigned(c_in);
			elsif(count='1') then
				counter <= counter+1;
			end if;
		end if;
	
	end process;
	
	c_out <= std_logic_vector(counter);
	
end Behavioral;


-- FAST COPY FOR USUAL SCHEMAS:
--
--component CounterNBits
--	generic(N: natural := 4);								-- Counter width
--	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
--	     clk:  in  std_logic;								-- Clock signal
--		  load: in  std_logic;								-- Load control bit
--		  count:in  std_logic;								-- Count bit
--		  c_in: in  std_logic_vector(N-1 downto 0);	-- Parallel load bits
--		  c_out:out std_logic_vector(N-1 downto 0));	-- Counter state
--end component;
--
--:CounterNBits 
-- generic map(N=> )
-- port map
--(
--		rst => ,
--		clk => ,
--		load => ,
--		count => ,
--		c_in => ,
--		c_out=> 
--);
