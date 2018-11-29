-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for the generic register with shift operations designed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegisterNBitsTest is
end ShiftRegisterNBitsTest;

architecture Behavioral of ShiftRegisterNBitsTest is 

	-- Component we are testing:
	component ShiftRegisterNBits
	generic(N: natural := 8);									-- Register width
	port(clk:   in std_logic;									-- Clock signal
		  rst:   in std_logic;									-- Reset signal
		  load:  in std_logic;									-- Load signal
		  sLeft: in std_logic;									-- Shift left signal
		  sRight:in std_logic;									-- Shift right signal
		  sBit:  in std_logic;									-- New bit for shift operations
		  r_in:  in std_logic_vector(N-1 downto 0);		-- Input signal for load operation
		  r_out:out std_logic_vector(N-1 downto 0));		-- Value stored
	end component;
	
	-- Signals needed:
	signal clk:   std_logic;
	signal rst:   std_logic;
	signal load:  std_logic;
	signal sLeft: std_logic;
	signal sRight:std_logic;
	signal sBit:  std_logic;
	signal r_in:  std_logic_vector(3 downto 0);
	signal r_out: std_logic_vector(3 downto 0);
	
	constant clk_period: time := 100 ns;
	
begin

	uut: ShiftRegisterNBits 
	generic map( N =>  4)
	port map
	(
		clk 	=> clk,
		rst 	=> rst,
	  	load 	=> load,
		sLeft => sLeft,
		sRight=> sRight,
		sBit  => sBit,
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
		
		rst   <='1';
		load  <='0';
		sLeft <='0';
		sRight<='0';
		sBit  <='0';
		r_in  <= (others=>'0');
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
		
		sLeft<= '1';
		sBit <='1';
		wait for clk_period;
		
		sBit <='0';
		wait for clk_period;
		
		sLeft<='0';
		sRight<='1';
		sBit <='1';
		wait for 4*clk_period;
		
		sBit<='0';
		wait for 4*clk_period;
		
	end process;

end Behavioral;

