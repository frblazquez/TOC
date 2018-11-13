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
			init:  in std_logic;		-- SITUATION REPORT WE RECEIVE
			zero:  in std_logic;		-- SITUATION REPORT WE RECEIVE
			lessA: in std_logic;    -- SITUATION REPORT WE RECEIVE
			control: out std_logic_vector (6 downto 0);
			cambio:  out std_logic;
			ended: 	out std_logic);
end controller;

architecture Behavioral of controller is

type STATE is (S0,S1,S2,S3,S4,S5);
signal actualState, nextState: STATE := S0;

-- ORDERS WE SENT TO DATAPATH!
signal controlAux: std_logic_vector(6 downto 0) := (others=>'0');
alias load_a: std_logic is controlAux(0); 
alias load_n: std_logic is controlAux(1);
alias load_r: std_logic is controlAux(2);
alias mux_n:  std_logic_vector(1 downto 0) is controlAux(4 downto 3);
alias mux_a:  std_logic is controlAux(5);
alias rst_r:  std_logic is controlAux(6);

signal actCambio, nextCambio: std_logic;

begin

-- Control contains all the control signals for the components
-- in the dataPath. From the controller we chose wich signals are
-- activated at each state.
control <= controlAux;
cambio <= actCambio;

-- Don't forget that an ASM is an finite state machine extended.
-- This is the synchronous state change.
process (clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
			actualState <= S0;
			actCambio   <= '0';
		else
			actualState <= nextState;
			actCambio   <= nextCambio;
		end if;
	end if;
end process;

-- Combinational output (function of the actual state, init and zero).
process(actualState,init,zero,actCambio,lessA)
begin

-- Default values:
	load_a <= '0';		-- Don't read register A
	load_n <= '0';		-- Don't read register N
	load_r <= '0';		-- Don't read register R
	mux_n  <= "00";	-- Chose N-1 for register N (instead of B input)
	mux_a  <= '0';    -- MuxA reads by default
	rst_r  <= '0';		-- Don't reset register R
	ended  <= '0';		-- The result is not correct yet!
	nextCambio <= actCambio;
	
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
 --mux_n  <= "00";	-- READ B_IN
 --mux_a  <= '0';		-- READ A_IN
	
	nextCambio <= '0';
	nextState <= S4;
	
when S2 =>

	if(zero='1') then
		nextState <= S0;
	else
		nextState <= S3;
	end if;

when S4 =>
	
	-- Estado en el que decidimos si hacer swap o no!
	
	if(lessA='1') then  -- !!!!!!!!!!!!!!!!!
		nextState <= S5;
	else
		nextState <= S3;
	end if;

when S5 =>

	-- Estado en el que hacemos el swap
	load_n <='1';
	load_a <='1';
	mux_n  <="10";
	mux_a  <='1';
	nextCambio <= '1';
	
	nextState <= S3;
	
when others =>

	load_n <= '1';
	mux_n  <= "01";
	load_r <= '1';
 
	nextState <= S2;
	
end case;

end process;

end Behavioral;

