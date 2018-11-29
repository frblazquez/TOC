-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic width synchronous register implementation.
-- 
--						     r_in
--    		   | |... N bits .. | |
--				 ------------------------
--		clk ->|						       |
--    rst ->|        REGISTER        |
--	  load ->|                        |
--				 ------------------------
--					| |... N bits .. | |
--						     r_out
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterNBits is
	generic(N: natural := 8);
	port(clk:  in  std_logic;
		  rst:  in  std_logic;
		  load: in  std_logic;
		  r_in: in  std_logic_vector(N-1 downto 0);
		  r_out:out std_logic_vector(N-1 downto 0));
end RegisterNBits;

architecture Behavioral of RegisterNBits is
	-- Output signal, value stored
	signal actValue:  std_logic_vector(N-1 downto 0);	
begin
	
	-- Output connection
	r_out <= actValue;
	
	-- Synchronous transitions (even reset is synchronous)
	process(clk)
	begin
		
		if(clk'event and clk='1') then
			if(rst='1') then
				actValue <= (others=>'0');
			elsif(load='1') then
				actValue <= r_in;
			end if;
		end if;
	
	end process;

end Behavioral;

-- FAST COPY FOR USUAL SCHEMAS
--
-- : RegisterNBits 
--	generic map( N =>  ) 
--	port map
--	(
--		clk 	=>
--		rst 	=>
--   	load 	=>
--		r_in  =>
--    r_out =>
-- );
--
-- component RegisterNBits
--	generic(N: natural := 8);
--	port(clk:  in  std_logic;
--		  rst:  in  std_logic;
--		  load: in  std_logic;
--		  r_in: in  std_logic_vector(N-1 downto 0);
--		  r_out:out std_logic_vector(N-1 downto 0));
-- end component;
