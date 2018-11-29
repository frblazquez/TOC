-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for the generic register designed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterNBitsTest is
end RegisterNBitsTest;

architecture Behavioral of RegisterNBitsTest is

	-- Component we are testing:
	component RegisterNBits
	generic(N: natural := 8);
	port(clk:  in  std_logic;
		  rst:  in  std_logic;
		  load: in  std_logic;
		  r_in: in  std_logic_vector(N-1 downto 0);
		  r_out:out std_logic_vector(N-1 downto 0));
	end component;
	
	-- Signals needed:
	signal clk:   std_logic;
	signal rst:   std_logic;
	signal load:  std_logic;
	signal r_in:  std_logic_vector(3 downto 0);
	signal r_out: std_logic_vector(3 downto 0);
	
	constant clk_period: time := 100 ns;
	
begin

	uut: RegisterNBits 
	generic map( N =>  4)
	port map
	(
		clk 	=> clk,
		rst 	=> rst,
	  	load 	=> load,
		r_in  => r_in,
	   r_out => r_out
	);
	
	-- Clock transitions process
	process
	begin
		
		if(clk='0') then 
			clk<='1';
		else
			clk<='0';
		end if;
		
		wait for clk_period/2;
		
	end process;
	
	-- Test cases:
	process 
	begin
		
		-- To create a little mismatch
		wait for 75 ns;
		
		rst  <='1';
		load <='0';
		r_in <= (others=>'0');
		wait for clk_period;
		
		rst<='0';
		load <='1';
		r_in <= (others=>'1');
		wait for clk_period;
		
		load <='0';
		wait for clk_period;
		
		r_in <= (others=>'0');
		wait for clk_period;
		
		r_in <= "0101";
		wait for clk_period;
		
		load <= '1';
		wait for clk_period;
		
		r_in <= "1010";
		wait for clk_period;
		
		load <= '0';
		wait for clk_period;
		
		rst <= '1';
		wait for clk_period;
		
		wait;
		
	end process;

end Behavioral;

