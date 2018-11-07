-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Controler for the ASM multiplier.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controller is
	port (clk: 	 in std_logic;
			reset: in std_logic;
			init:  in std_logic;
			zero:  in std_logic;
			control: out std_logic_vector (4 downto 0);
			ended: 	out std_logic);
end controller;

architecture Behavioral of controller is

type STATE is (S0,S1,S2,S3);
signal actualState, nextState: STATE := S0;

signal controlAux: std_logic_vector(4 downto 0);
alias load_a: std_logic is control_aux(0);
alias load_n: std_logic is control_aux(1);
alias load_r: std_logic is control_aux(2);
alias mux_n:  std_logic is control_aux(3);
alias rst_r:  std_logic is control_aux(4);

begin

-- Control contains all the control signals for the components
-- in the dataPath. From the controller we chose wich signals are
-- activated at each state.
control <= control_aux;

-- Don't forget that an ASM is an finite state machine extended.
-- This is the synchronous state change.
process (clk, reset)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
			actualState <= S0;
		else
			actualState <= nextState;
		end if;
	end if;
end process;

-- Combinational output (function of the actual state).
process(actualState,init,zero)
begin

-- Default values:
	load_a <= '0';
	load_n <= '0';
	load_r <= '0';
	mux_n  <= '0';
	rst_r  <= '0';
	ended  <= '0';
	
case actualState is
when S0 =>
	
	ended <= '1';
	
	if(init='1') then
		nextState <= S1;
	else 
		nextState <= S0;
	end if;

when S1 =>
	
	rst_r  <= '1';
	load_a <= '1';
	load_n <= '1';
	mux_n  <= '1';
	
	nextState <= S2;
	
when S2 =>

	if(zero='1') then
		nextState <= S0;
	else
		nextState <= S3;
	end if;

when others =>

	load_n <= '1';
	load_r <= '1';
 --load_a <= '0';
 --mux_n  <= '0';
 --rst_r  <= '0';
	
end case;

end process;

end Behavioral;

