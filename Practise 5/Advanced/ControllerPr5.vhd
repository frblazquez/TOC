-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Controller for the slot machine.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControllerPr5 is
	port(rst:    in std_logic;		-- Reset signal
	     clk:    in std_logic;		-- Clock signal
		  ini:    in std_logic;		-- Start counting signal
		  fin:    in std_logic;		-- Stop counting signal
		  equal:  in std_logic;		-- Both counters have equal value
		  timeOut:in std_logic;		-- Time for led sequence is out
		  control: out std_logic_vector(10 downto 0));
end ControllerPr5;

architecture Behavioral of ControllerPr5 is

	-- Signals to execute instructions in datapath:
	signal control_aux: std_logic_vector(10 downto 0);
	alias counter1_rst: 				std_logic is control_aux(0);
	alias counter2_rst: 				std_logic is control_aux(1);
	alias count: 						std_logic is control_aux(2);
	alias getClients_rst: 			std_logic is control_aux(3);
	alias getClients_shiftRight: 	std_logic is control_aux(4);
	alias looser_load: 				std_logic is control_aux(5);
	alias looser_shiftRight: 		std_logic is control_aux(6);
	alias winner_load: 				std_logic is control_aux(7);
	alias leds_mux: 					std_logic_vector(1 downto 0) is control_aux(9 downto 8);
	alias timer_rst: 					std_logic is control_aux(10);
	
	type States is (S0, S1, S2);
	
	signal state: States := S0;
	signal nextState: States := S0;
	
begin

	control <= control_aux;
	
	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(rst='1') then
				state <= S0;
			else
				state <= nextState;
			end if;
		end if;
		
	end process;
	
	process(state, ini, fin, equal, timeOut)
	begin
	
		counter1_rst <= '0';
		counter2_rst <= '0';
		count <= '0';
		getClients_rst <= '0';
		getClients_shiftRight <= '0';
		looser_load <= '0';
		looser_shiftRight <= '0';
		winner_load <= '0';
		leds_mux <= "00";
		timer_rst <= '1';
		
		nextState <= S0;
	
	case state is
	when S0 =>
	
		-- Counters back to 0:
		counter1_rst <= '1';
		counter2_rst <= '1';
		
		-- getCliends sequence:
		getClients_shiftRight <= '1';
		
		-- We prepare winning and looser sequence:
		looser_load <= '1';
		
		-- Next state:
		if(ini='1') then
			nextState <= S1;
		end if;
	
	when S1 =>
		
		-- Counters counting (with their own frecuency)
		count <= '1';
	
		-- getClients back to 0:
		getClients_rst <= '1';
	
		-- Next state:
		if(fin='1') then
			nextState <= S2;
		else
			nextState <= S1;
		end if;
	
	when others =>
	
		-- Looser and winner sequence working:
		looser_shiftRight <= '1';
		winner_load <= '1';
		
		-- Wich of two sequences should be shown?
		if(equal='1') then
			leds_mux<= "10";
		else
			leds_mux<= "01";
		end if;
		
		-- Timer starts counting:
		timer_rst <= '0';
	
		-- When time out is not reached, continue in S2:
		if(timeOut='0') then
			nextState <= S2;
		end if;
	
	end case;
	
	end process;

end Behavioral;

