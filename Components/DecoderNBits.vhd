-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic decoder. N is the number of control bits.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DecoderNBitsControl is
	generic(N: natural := 4);
	port(ctrl:  in  std_logic_vector(N-1 downto 0);		 -- Control bits
		  d_out: out std_logic_vector(2**N-1 downto 0)); -- Out bit
end DecoderNBitsControl;

architecture Behavioral of DecoderNBitsControl is

begin

	process(ctrl)
	begin
		
		d_out <= (others=>'0');
		d_out(to_integer(unsigned(ctrl))) <= '1';

	end process;
 
end Behavioral;

-- FAST COPY FOR USUAL SCHEMAS
--
-- : DecoderNBitsControl 
-- generic map(N => )
-- port map
--	(
--		ctrl 	=>
--		d_out =>
-- );
--
-- component DecoderNBitsControl
--	generic(N: natural := 4);
--	port(ctrl:  in  std_logic_vector(N-1 downto 0);		 -- Control bits
--		  d_out: out std_logic_vector(2**N-1 downto 0)); -- Out bit
-- end component;