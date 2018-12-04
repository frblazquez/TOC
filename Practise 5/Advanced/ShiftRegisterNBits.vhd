-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic width synchronous register implementation with
-- shift-left and shift-right operations.
-- 
--						     r_in
--    		   | |... N bits .. | |
--				 ------------------------
--		clk ->|						       |<- sLeft
--    rst ->|        REGISTER        |
--	  load ->|                        |<- sRight
--				 ------------------------
--					| |... N bits .. | |
--						     r_out
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegisterNBits is
	generic(N: natural := 8);									-- Register width
	port(clk:   in std_logic;									-- Clock signal
		  rst:   in std_logic;									-- Reset signal
		  load:  in std_logic;									-- Load signal
		  sLeft: in std_logic;									-- Shift left signal
		  sRight:in std_logic;									-- Shift right signal
		  sBit:  in std_logic;									-- New bit for shift operations
		  r_in:  in std_logic_vector(N-1 downto 0);		-- Input signal for load operation
		  r_out:out std_logic_vector(N-1 downto 0));		-- Value stored
end ShiftRegisterNBits;

architecture Behavioral of ShiftRegisterNBits is
	-- Output signal, value stored
	signal actValue:  std_logic_vector(N-1 downto 0) := (others=>'0');	
	signal nextValue: std_logic_vector(N-1 downto 0) := (others=>'0');
	
begin
	
	-- Output connection
	r_out <= actValue;
	
	-- Synchronous transitions (even reset is synchronous)
	process(clk)
	begin
		
		if(clk'event and clk='1') then
			if(rst='1') then
				actValue <= (others=>'0');
			else
				actValue <= nextValue;
			end if;
		end if;
	
	end process;
	
	process(actValue, load, sRight, sLeft, sBit, r_in)
	begin
		
		if(load='1') then
			nextValue <= r_in;
		elsif(sRight='1') then
			nextValue(N-2 downto 0) <= actValue(N-1 downto 1);
			nextValue(N-1)          <= sBit; -- actValue(0)   for circular register!
		elsif(sLeft='1') then
			nextValue(N-1 downto 1) <= actValue(N-2 downto 0);
			nextValue(0)            <= sBit; -- actValue(N-1) for circular register!
		else
			nextValue <= actValue;
		end if;
	
	end process;

end Behavioral;

-- FAST COPY FOR USUAL SCHEMAS
--
--component ShiftRegisterNBits
--	generic(N: natural := 8);									-- Register width
--	port(clk:   in std_logic;									-- Clock signal
--		  rst:   in std_logic;									-- Reset signal
--		  load:  in std_logic;									-- Load signal
--		  sLeft: in std_logic;									-- Shift left signal
--		  sRight:in std_logic;									-- Shift right signal
--		  sBit:  in std_logic;									-- New bit for shift operations
--		  r_in:  in std_logic_vector(N-1 downto 0);		-- Input signal for load operation
--		  r_out:out std_logic_vector(N-1 downto 0));		-- Value stored
--end component;
--
-- : ShiftRegisterNBits 
--	generic map( N =>  ) 
--	port map
--	(
--		clk 	=>
--		rst 	=>
--   	load 	=>
--    sLeft =>
--    sRight=>
--    sBit  =>
--		r_in  =>
--    r_out =>
-- );
