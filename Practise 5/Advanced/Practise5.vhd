-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise 5 TOC. Slot machine design.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Practise5 is
	port(rst: in std_logic;									-- Reset signal(0 means reset!)
		  clk: in std_logic;									-- Clock signal (expected 100MHz)
		  ini: in std_logic;									-- Start counting signal (0 means start!)
		  fin: in std_logic;									-- Stop counting signal	 (0 means stop!)
		  leds: out std_logic_vector(9 downto 0);		-- Luminic output
		  num_1:out std_logic_vector(6 downto 0);		-- 7_segment counter 1 output
		  num_2:out std_logic_vector(6 downto 0));	-- 7_segment counter 2 output
end Practise5;

architecture Behavioral of Practise5 is

	component FrequencyDivisor is
	port(rst:     in  std_logic; -- Reset signal (asynchronous)
		  clk_in:  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)	
		  clk_1Hz: out std_logic; -- Clock signal output (1 Hz frequency)
		  clk_1:	  out std_logic; -- Clock signal for count 1, 50MHz frequency
		  clk_2:   out std_logic);-- Clock signal for count 2, 12.5MHz frequency
	end component;
	
	component PushButtonDebouncer
	port(rst:  in  std_logic;			-- Reset signal (asynchronous)
		  clk:  in  std_logic;			-- Clock signal (expected 100MHz signal)
		  x:    in  std_logic;			-- Input from the push button or switch
		  xDeb: out std_logic;			-- x signal debounced ~ x signal steadier
		  xDebFalling: out std_logic;	-- Indicates when x signal goes from high to low
		  xDebRising:  out std_logic);-- Indicates when x signal goes from low to high
	end component;
	
	component conv_7seg
	    Port ( x : in  std_logic_vector(3 downto 0);
	           display : out  std_logic_vector(6 downto 0));
	end component;
	
	component DataPathPr5
	port(rst: 		in std_logic;										-- Reset signal
		  clk: 		in std_logic;										-- Clock signal
		  control: 	in std_logic_vector(10 downto 0);			-- Control bits (see alias)
		  iguales: out std_logic;										-- Equal bit
		  timeOut: out std_logic;										-- Time for led squence ended
		  contador1Out:  out std_logic_vector( 3 downto 0);	-- Counter1(mod 10) out
		  contador2Out:  out std_logic_vector( 3 downto 0);	-- Counter2(mod 10) out
		  ledsOut:       out std_logic_vector(9 downto 0));	-- Leds out
	end component;
	
	component ControllerPr5
	port(rst:    in std_logic;		-- Reset signal
	     clk:    in std_logic;		-- Clock signal
		  ini:    in std_logic;		-- Start counting signal
		  fin:    in std_logic;		-- Stop counting signal
		  equal:  in std_logic;		-- Both counters have equal value
		  timeOut:in std_logic;		-- Time for led sequence is out
		  control: out std_logic_vector(10 downto 0));
	end component;
	
	-- Signals for the push buttons:
	signal rst_high:   std_logic;		-- rst_high='1' when reset button is pressed
	signal ini_high:   std_logic;		-- ini_high='1' when ini   button is pressed
	signal fin_high:   std_logic;		-- fin_high='1' when fin   button is pressed
	signal ini_rising: std_logic;		-- ini_rising='1' for a clk period each time ini is pressed
	signal fin_rising: std_logic;		-- fin_rising='1' for a clk period each time fin is pressed
	
	-- Signals for controller-dataPath comunication:
	signal equal: std_logic;
	signal timeOut: std_logic;
	signal control: std_logic_vector(10 downto 0);
	
	signal counter1_out: std_logic_vector(3 downto 0);
	signal counter2_out: std_logic_vector(3 downto 0);
	
begin

	-- Elements from push button connections will be high level when not pressed,
	-- what we want is having high level when pressing them
	rst_high <= not(rst);
	ini_high <= not(ini);
	fin_high <= not(fin);
	
	ini_button: PushButtonDebouncer port map
	(
		rst => rst_high,
		clk => clk,
		x   => ini_high,
		xDebRising => ini_rising
	--	xDeb=> 
	--	xDebFalling=> 	
	);
	
	fin_button: PushButtonDebouncer port map
	(
		rst => rst_high,
		clk => clk,
		x   => fin_high,
		xDebRising => fin_rising
	--	xDeb=> 
	--	xDebFalling=> 	
	);
	
	dataPath:DataPathPr5 port map
	(
		rst     		 => rst_high,
		clk 			 => clk,
		control 		 => control,
		iguales 		 => equal,
		timeOut 		 => timeOut,
		contador1Out => counter1_out,
		contador2Out => counter2_out,
		ledsOut 		 => leds
	);
	
	controller:ControllerPr5 port map
	(
		rst  		=> rst_high,
	   clk		=> clk,
		ini		=> ini_rising,
		fin		=> fin_rising,
		equal		=> equal,
		timeOut	=> timeOut,
		control	=> control
	);
	
	conv1: conv_7seg port map
	(
		x		  => counter1_out,
		display => num_1
	);
	
	conv2: conv_7seg port map
	(
		x		  => counter2_out,
		display => num_2
	);
	

end Behavioral;

