-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Test for the debouncer and frequency divisor designed for
-- practise 5.
--
--	leds1 <= "0000" but for a clk_period each second.
-- leds2 <= "1111" when count button is pressed, "0000" when others.
-- num1  <= 7 segments representation for counter 1.
-- num2  <= 7 segments representation for counter 2.
-- num3  <= 7 segments representation for counter 3.
--
-- Each time count button is   pressed counter1 <= counter1 + 1; (mod 10)
-- Each time count button is depressed counter2 <= counter2 + 1; (mod 10)
-- Each second counter3 <= counter3 + 1; (mod 10)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DebouncerFPGATest is
	port(rst:   in  std_logic;							 -- Reset signal (from push button)
		  clk:   in  std_logic;							 -- Clock signal (should be 100MHz)
		  count: in  std_logic;							 -- Count signal (from push button)
	     leds:  out std_logic_vector(4 downto 0); -- Leds out (High when count is pressed)
		  num1:	out std_logic_vector(6 downto 0); -- 7 segment format for counter 1 output
		  num2:  out std_logic_vector(6 downto 0); -- 7 segment format for counter 2 output
		  num3:  out std_logic_vector(3 downto 0));-- 7 segment format for counter 3 output
end DebouncerFPGATest;

architecture Behavioral of DebouncerFPGATest is

	component CounterMod10
		port(rst:  in  std_logic;								-- Reset signal (back to others=>0) (Sync.)
		     clk:  in  std_logic;								-- Clock signal
			  count:in  std_logic;								-- Count bit
			  c_out:out std_logic_vector(3 downto 0));	-- Counter state
	end component;
	
	component FrequencyDivisor
		port(rst:     in  std_logic; -- Reset signal (asynchronous)
			  clk_in:  in  std_logic; -- Clock signal input  (Should be 100MHz square signal)
			  clk_out: out std_logic);-- Clock signal output (Will be 1/100M clock input frequency)
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
	port(x: 			in  STD_LOGIC_VECTOR (3 downto 0);
	     display: out  STD_LOGIC_VECTOR (6 downto 0));
	end component;

	-- Clock 1Hz periodic signal:
	signal clk_1Hz: std_logic;

	-- Signals to debounce the push button:
	signal rst_high: std_logic;
	signal count_high: std_logic;
	signal count_debounced: std_logic;
	
	-- Signals for the counters:
	signal count1:  std_logic;
	signal count2:	 std_logic;
	signal counter1_out: std_logic_vector(3 downto 0);
	signal counter2_out: std_logic_vector(3 downto 0);
	
begin

	frequencies: FrequencyDivisor port map
	(
		rst		=> rst_high,
		clk_in	=> clk,
		clk_out  => clk_1Hz
	);
	 
	debouncer:PushButtonDebouncer port map
	(
		rst 			=> rst_high,
		clk 			=> clk,
		x				=> count_high,
		xDeb			=> count_debounced,
		xDebRising	=> count1,
		xDebFalling	=> count2
	);
	
	counter1: CounterMod10 port map
	(
		rst 	=> rst_high,
		clk	=> clk,
		count	=> count1,				
		c_out => counter1_out
	);
	
	counter2: CounterMod10 port map
	(
		rst 	=> rst_high,
		clk	=> clk,
		count	=> count2,				
		c_out => counter2_out
	);
	
	counter3: CounterMod10 port map
	(
		rst 	=> rst_high,
		clk	=> clk,
		count	=> clk_1Hz,				
		c_out => num3
	);
	
	conv1: conv_7seg port map
	(
		x 		  => counter1_out,
	   display => num1
	);
	
	conv2: conv_7seg port map
	(
		x 		  => counter2_out,
	   display => num2
	);
	
	-- We want count signal to be '1' when the button is pressed:
	count_high <= not(count);
	rst_high   <= not(rst);
	
	-- Left leds will show wether the button is pressed:
	leds <= "11111" when count_debounced='1' else "00000";

end Behavioral;
