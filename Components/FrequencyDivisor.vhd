-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Frequency divisor. From 100MHz to 1Hz.
-- This component can be easily modified for changing
-- the output frequency to any old.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FrequencyDivisor is
	port(rst:     in  std_logic; -- Reset signal (asynchronous)
		  clk_in:  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)
		  clk_1Hz: out std_logic; -- Clock signal output (Will be 1/100M clock input frequency)
		  clk_1:   out std_logic; -- Clock signal aux   (Will be 1/2 clock input frequency)
		  clk_2:   out std_logic);-- Clock signal aux 2 (Will be 1/5 clock input frequency)
end FrequencyDivisor;

architecture Behavioral of FrequencyDivisor is

-- With a 100MHz clock, 100M (Binary ~ "101111101011110000100000000") cycles is 1s
	constant ONE_SEC: unsigned(26 downto 0) := "101111101011110000100000000";
                                                
-- Just for having a counter
	signal count: unsigned(26 downto 0):= (others=>'0');
	
begin

	process(clk_in, rst)
	begin
		
		if(rst='1') then
			count <= (others=>'0');
			clk_1Hz <= '0';
		elsif(rising_edge(clk_in)) then
			if(count=ONE_SEC) then
				clk_1Hz <= '1';
				count <= (others=>'0');
			else
				clk_1Hz <= '0';
				count <= count+1;
			end if;
		end if;
		
		clk_1 <= count(0);
		clk_2 <= count(4);
		
	end process;

end Behavioral;

-- FAST COPY FOR USUAL SCHEMAS:
--
--component FrequencyDivisor is
--	port(rst:     in  std_logic; -- Reset signal (asynchronous)
--		  clk_in:  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)
--		  clk_out: out std_logic);-- Clock signal output (Will be 1/100M clock input frequency)
--end component;
--
-- :FrequencyDivisor port map
--(
--		rst=> ,
--		clk_in=> ,
--		clk_1Hz=>,
--    clk_1 =>,
--    clk_2 => 
--);

