-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Debouncer for a push button.
--
-- Comments: Don't forget that in Spartan3 FPGA (as in 
--           most os FPGAs) every push button is at high
--           level when it's not pressed.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PushButtonDebouncer is
	port(rst:  in  std_logic;			-- Reset signal (asynchronous)
		  clk:  in  std_logic;			-- Clock signal (expected 100MHz signal)
		  x:    in  std_logic;			-- Input from the push button or switch
		  xDeb: out std_logic;			-- x signal debounced ~ x signal steadier
		  xDebFalling: out std_logic;	-- Indicates when x signal goes from high to low
		  xDebRising:  out std_logic);-- Indicates when x signal goes from low to high
end PushButtonDebouncer;

architecture Behavioral of PushButtonDebouncer is
	
	type States is (WaitingPush, DebouncePush,waitingDepression, DebounceDepression);
	signal xSync, xSyncBefore: std_logic;
	signal state, nextState: States := WaitingPush;
	signal count, nextCount: unsigned(23 downto 0) := (others=>'0');
	
	-- With a 100MHz clock, 10M (Binary ~ "100110001001011010000000") cycles is 100ms
	constant HUNDRED_MS: unsigned(23 downto 0) := "100110001001011010000000";
	
begin

	-- Process to make x signal synchronous. In order to avoid having
	-- non high neither low values (middle values being read) we force
	-- x signal to go through two flip-flops.
	-- Synchronice x signal also helps us for having an steady xDebFalling
	-- and xDebRising signal for a clock period time.
	process(clk,rst,x)
	begin
		
		if(rst='1') then
			xSync <= '0';
			xSyncBefore <='0';
		elsif(rising_edge(clk)) then
			xSync <= xSyncBefore;
			xSyncBefore <= x;
		end if;
	
	end process;
	
	-- Process for the state transitions. The idea is the following:
	-- wait until xSync (~ x) is high, then wait for 100 ms during wich
	-- we don't take in consideration xSync value (to avoid reading non
	-- static values). Then wait until xSync is low again to know when the
	-- push button is unpressed.
	process(clk,rst,nextState)
	begin
	
		if(rst='1') then
			state <= WaitingPush;
			count <= (others=>'0');
		elsif(rising_edge(clk)) then
			state <= nextState;
			count <= nextCount;
		end if;
		
	end process;
	
	-- Process for the output signals. We implement this debouncer
	-- as a mealy machine.
	process(state, xSync, count)
	begin
		
		xDeb <= '0';
		xDebFalling <= '0';
		xDebRising <= '0';
		nextState <= state;
		nextCount <= (others=>'0');
		
		case state is
		when WaitingPush =>
			
			if(xSync='1') then
				xDeb<='1';
				xDebRising<='1';
				nextState<= DebouncePush;
			end if;
		
		when DebouncePush =>
		
			xDeb <='1';
			nextCount<= count + 1;
			
			if(count=HUNDRED_MS) then
				nextState <= WaitingDepression;
			end if;
		
		when WaitingDepression =>
			
			xDeb <='1';
			
			if(xSync='0') then
				xDeb<='0';
				xDebFalling<='1';
				nextState<= DebounceDepression;
			end if;
		
		when others => -- DebounceDepression
			
			nextCount <= count+1;
			
			if(count=HUNDRED_MS) then
				nextState <= WaitingPush;
			end if;
			
		end case;
		
	end process;
	
end Behavioral;


-- FAST COPY FOR USUAL SCHEMAS:
--
--	component PushButtonDebouncer
--	port(rst:  in  std_logic;			-- Reset signal (asynchronous)
--		  clk:  in  std_logic;			-- Clock signal (expected 100MHz signal)
--		  x:    in  std_logic;			-- Input from the push button or switch
--		  xDeb: out std_logic;			-- x signal debounced ~ x signal steadier
--		  xDebFalling: out std_logic;	-- Indicates when x signal goes from high to low
--		  xDebRising:  out std_logic);-- Indicates when x signal goes from low to high
--	end component;
--
--	uut: PushButtonDebouncer port map
--	(
--		rst =>
--		clk =>
--		x   =>
--		xDeb=> 
--		xDebRising =>
--		xDebFalling=> 	
--	);

