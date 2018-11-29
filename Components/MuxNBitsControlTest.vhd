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

entity MuxNBitsControlTest is
end MuxNBitsControlTest;

architecture Behavioral of MuxNBitsControlTest is

	-- Component we are testing:
	component MuxNBitsControl
	generic(N: natural := 2);
	port(E:     in  std_logic;									-- Enable bit
		  ctrl:  in  std_logic_vector(N-1 downto 0);		-- Control bits
		  m_in:  in  std_logic_vector(2**N-1 downto 0);	-- Input bits
		  m_out: out std_logic);								-- Out bit
	end component;
	
	-- Signals needed:
	constant clk_period: time := 100 ns;
	signal clk: std_logic;
	
	signal Enable: std_logic := '0';
	signal ctrl:   std_logic_vector(2 downto 0) := (others =>'0');
	signal m_in:   std_logic_vector(7 downto 0) := (others =>'0');
	signal m_out:  std_logic;
	
begin

	uut: MuxNBitsControl 
	generic map(N => 3)
	port map
	(
		E     => Enable,
		ctrl 	=>	ctrl,
		m_in 	=>	m_in,
		m_out =>	m_out
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
				
		Enable <= '0';
		ctrl   <= "111";
		m_in   <= "11110000";
		wait for clk_period;
		
		Enable <= '1';
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

