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

entity PriorityCoderNBitsOut is
	generic(N: natural := 4);
	port(c_in:  in std_logic_vector(2**N-1 downto 0);
	     c_out:out std_logic_vector(N-1 downto 0)); -- Out bit
end PriorityCoderNBitsOut;

architecture Behavioral of PriorityCoderNBitsOut is

begin

	process(c_in)
		variable continue: std_logic :='1';
	begin
		
		c_out <= (others=>'0');
		
		for i in 2**N-1 downto 0 loop
		
			if(continue='1') then
				if(c_in(i)='1') then
					c_out <= std_logic_vector(to_unsigned(i,N));
					continue := '0';
				else
					continue := '1';
				end if;
			else
				continue := '0';
			end if;
		
		end loop;

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