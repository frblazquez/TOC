-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for the generic with multiplexor designed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DecoderNBitsControlTest is
end DecoderNBitsControlTest;

architecture Behavioral of DecoderNBitsControlTest is

	-- Component we are testing:
	component DecoderNBitsControl
		generic(N: natural := 4);
		port(ctrl:  in  std_logic_vector(N-1 downto 0);		 -- Control bits
			 d_out: out std_logic_vector(2**N-1 downto 0)); -- Out bit
	end component;
	
	-- Signals needed:
	constant clk_period: time := 100 ns;
	signal clk: std_logic;
	
	signal ctrl:   std_logic_vector(2 downto 0) := (others =>'0');
	signal d_out:  std_logic_vector(7 downto 0);
	
begin

	uut: DecoderNBitsControl 
	generic map(N => 3)
	port map
	(
		ctrl 	=>	ctrl,
		d_out =>	d_out
	);

	-- Clock is not necessary, however we'll use it to see 
	-- and control the transitions.
	
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
				
		ctrl   <= "111";
		wait for clk_period;
		
		ctrl <= "000";
		wait for clk_period;
		
		ctrl <= "001";
		wait for clk_period;
		
		ctrl <= "101";
		wait for clk_period;
		
		ctrl <= "011";
		wait for clk_period;
		
		wait;
		 
	end process;

end Behavioral;

