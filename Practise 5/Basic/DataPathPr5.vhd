-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Controller for the slot machine.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataPathPr5 is 
	port(rst: 		in std_logic;										-- Reset signal
		  clk: 		in std_logic;										-- Clock signal
		  control: 	in std_logic_vector(10 downto 0);			-- Control bits (see alias)
		  iguales: out std_logic;										-- Equal bit
		  timeOut: out std_logic;										-- Time for led squence ended
		  contador1Out:  out std_logic_vector( 3 downto 0);	-- Counter1(mod 10) out
		  contador2Out:  out std_logic_vector( 3 downto 0);	-- Counter2(mod 10) out
		  ledsOut:       out std_logic_vector(9 downto 0));	-- Leds out
end DataPathPr5;

architecture Behavioral of DataPathPr5 is

	component CounterMod10
	port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
	     clk:  in  std_logic;								-- Clock signal
		  count:in  std_logic;								-- Count bit
		  c_out:out std_logic_vector(3 downto 0));	-- Counter state
	end component;
	
	component ShiftRegisterNBits
	generic(N: natural := 8);									-- Register width
	port(clk:   in std_logic;									-- Clock signal
		  rst:   in std_logic;									-- Reset signal
		  load:  in std_logic;									-- Load signal
		  sLeft: in std_logic;									-- Shift left signal
		  sRight:in std_logic;									-- Shift right signal
		  sBit:  in std_logic;									-- New bit for shift operations
		  r_in:  in std_logic_vector(N-1 downto 0);		-- Input signal for load operation
		  r_out:out std_logic_vector(N-1 downto 0));		-- Value stored
	end component;
	
	component FrequencyDivisor is
		port(rst:     in  std_logic; -- Reset signal (asynchronous)
			  clk:  	  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)
			  clk_1Hz: out std_logic; -- Clock signal output (Will be 1/100M clock input frequency)
			  clk_1:   out std_logic; -- Clock signal output (Will be 1/2  clock input frequency)
			  clk_2:   out std_logic);-- Clock signal output (Will be 1/32 clock input frequency)
	end component;
	
	-- Frequecy signals:
	signal clk_1Hz: std_logic;
	signal clk_1:	 std_logic;
	signal clk_2:   std_logic;
	
	-- Signals from controller:
	alias counter1_rst: 				std_logic is control(0);
	alias counter2_rst: 				std_logic is control(1);
	alias count: 						std_logic is control(2);
	alias getClients_rst: 			std_logic is control(3);
	alias getClients_shiftRight: 	std_logic is control(4);
	alias looser_load: 				std_logic is control(5);
	alias looser_shiftRight: 		std_logic is control(6);
	alias winner_load: 				std_logic is control(7);
	alias leds_mux: 					std_logic_vector(1 downto 0) is control(9 downto 8);
	alias timer_rst: 					std_logic is control(10);
	
	-- Counter signals:
	signal count1: std_logic;
	signal count2: std_logic;
	signal counter1_out: std_logic_vector(3 downto 0);
	signal counter2_out: std_logic_vector(3 downto 0);
	
	-- Leds signals:
	signal getClients_out: std_logic_vector(9 downto 0);
	signal getClients_fillBit: std_logic; -- Bit entering when shift right
	signal looser_out: std_logic_vector(9 downto 0);
	signal looser_fillBit: std_logic;
	signal winner_out: std_logic_vector(9 downto 0);
	signal winner_in: std_logic_vector(9 downto 0);
	signal timer_out: std_logic_vector(3 downto 0);
	
	-- Constants needed:
	constant ZERO: std_logic := '0';
	constant UNO:  std_logic := '1';
	constant ZERO_VECTOR: std_logic_vector(9 downto 0) := (others=>'0');
	constant BAD_LUCK:    std_logic_vector(9 downto 0) := "0101010101";
	constant TIME_SEQUENCE: integer := 5; -- <= 10 !!
	
begin

	-- Variable frequencies needed:
	 frecuencies: FrequencyDivisor port map
	(
		rst     => rst,
		clk     => clk,
		clk_1Hz => clk_1Hz,
	   clk_1   => clk_1,
	   clk_2   => clk_2
	);
	
	--------------------------- COUNTERS -------------------------------	
	-- Counter 1 and 2 will count when controller sais they count and
	-- at the same time the frequency bit sais they count.
	-- This lets us to control the count frequency.
	count1 <= count and clk_1;
	count2 <= count and clk_2;
	
	counter1:CounterMod10 port map
	(
		rst => counter1_rst,
		clk => clk,
		count => count1,
		c_out=> counter1_out
	);
	
	counter2:CounterMod10 port map
	(
		rst => counter2_rst,
		clk => clk,
		count => count2,
		c_out=> counter2_out
	);
	
	-- Counter outputs goes directly out:
	contador1Out <= counter1_out;
	contador2Out <= counter2_out;
	
	-- Equal bit depends on the counters situation:
	iguales <= '1' when counter1_out=counter2_out else '0';
	
	--------------------------- LEDS --------------------------------
	getClients: ShiftRegisterNBits 
	generic map( N =>  10) 
	port map
	(
		clk 	=> clk_1Hz,
		rst 	=> getClients_rst,
	 	load 	=> ZERO,
	   sLeft => ZERO,
	   sRight=> getClients_shiftRight,
	   sBit  => getClients_fillBit,
		r_in  => ZERO_VECTOR,
	   r_out => getClients_out
	);
	
	-- This way we can create the sequence asked:
	getClients_fillBit <= not(getClients_out(0));
	
	looser: ShiftRegisterNBits 
	generic map( N =>  10) 
	port map
	(
		clk 	=> clk_1Hz,
		rst 	=> rst,
	 	load 	=> looser_load,
	   sLeft => ZERO,
	   sRight=> looser_shiftRight,
	   sBit  => looser_fillBit,
		r_in  => BAD_LUCK,
	   r_out => looser_out
	);
	
	-- This way we can create the sequence asked:
	looser_fillBit <= looser_out(0);
	
	winner: ShiftRegisterNBits 
	generic map( N =>  10) 
	port map
	(
		clk 	=> clk_1Hz,
		rst 	=> rst, -- winner_rst!!
	-- Not controlling winning register reset signal implies that we can't control
	-- the first situation of the leds (shining or not). However the sequence will
	-- be correct.
	 	load 	=> winner_load,
	   sLeft => ZERO,
	   sRight=> ZERO,
	   sBit  => ZERO,
		r_in  => winner_in,
	   r_out => winner_out
	);
	
	-- winner_in <= not(winner_out);
	winner_in(9) <= not(winner_out(9)); winner_in(8) <= not(winner_out(8));
	winner_in(7) <= not(winner_out(7)); winner_in(6) <= not(winner_out(6));
	winner_in(5) <= not(winner_out(5)); winner_in(4) <= not(winner_out(4));
	winner_in(3) <= not(winner_out(3)); winner_in(2) <= not(winner_out(2));
	winner_in(1) <= not(winner_out(1)); winner_in(0) <= not(winner_out(0));
	
	-- Timer for being 10s showing the result:
	timer:CounterMod10 port map
	(
		rst => timer_rst,
		clk => clk_1Hz,
		count => UNO,
		c_out=> timer_out
	);
	
	timeOut <= '1' when (to_integer(unsigned(timer_out))+1)= TIME_SEQUENCE else '0';
	
	-- Vectorial multiplexor for the leds output:
	with leds_mux select 
	ledsOut <=  getClients_out when "00",
					looser_out     when "01",
					winner_out     when others;
	
end Behavioral;

