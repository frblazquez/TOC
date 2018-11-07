-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Generic synchronous parallel register.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_n is
	generic (n: natural := 8);
	port (clk: in std_logic;
		   rst: in std_logic;
		   load: in std_logic;
	   	din: in std_logic_vector(n-1 downto 0);
		   dout: out std_logic_vector(n-1 downto 0));
end register_n;

architecture Behavioral of register_n is
	
begin

process(clk)
begin

	if(clk'event and clk='1') then
		if(rst='1') then
			dout <= (others =>'0');
		elsif(load='1') then
			dout <= din;
		end if;
	end if;

end process;


end Behavioral;

