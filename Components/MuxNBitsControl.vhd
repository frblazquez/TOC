-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic width 2**Nto1 multiplexor.
-- Generic parameter N is the number of control bits.
-- 
--	m_in ->	 x0 x1 ................ x2**n-1	     
--    		  | |... 2**N bits .. | |
--				 -------------------------
--		E ->	|	|				   	  |  |
--    		|        |         |      |
--	 Ctrl-> 	|             |           |
--				 ------------------------
--								  |	
--						      m_out
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MuxNBitsControl is
	generic(N: natural := 2);
	port(E:     in  std_logic;										-- Enable bit
		  ctrl:  in  std_logic_vector(N-1 downto 0);			-- Control bits
		  m_in:  in  std_logic_vector((2**N)-1 downto 0);	-- Input bits
		  m_out: out std_logic);									-- Out bit
end MuxNBitsControl;

architecture Behavioral of MuxNBitsControl is
	-- To point the bit selected
	signal i: integer;
begin

	i     <= to_integer(unsigned(ctrl));
	m_out <= E and m_in(i);
	
end Behavioral;

-- FAST COPY FOR USUAL SCHEMAS
--
-- : MuxNBitsControl 
-- generic map(N => )
-- port map
--	(
--		E     =>
--		ctrl 	=>
--   	m_in 	=>
--		m_out =>
-- );
--
-- component MuxNBitsControl
--	generic(N: natural := 2);
--	port(E:     in  std_logic;									-- Enable bit
--		  ctrl:  in  std_logic_vector(N-1 downto 0);		-- Control bits
--		  m_in:  in  std_logic_vector(2**N-1 downto 0);	-- Input bits
--		  m_out: out std_logic);								-- Out bit
-- end component;

