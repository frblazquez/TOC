-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Simulation for a digital padlock.

library IEEE;use IEEE.STD_LOGIC_1164.ALL;use IEEE.STD_LOGIC_ARITH.All;use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Pr2 is
	port(rst: 	     in std_logic;	-- From a push button and asynchronous
		  clk: 	     in std_logic;	-- For the push button implementation
		  check:	     in std_logic; 	-- From push button (and throught debouncer)
		  key_entry:  in std_logic_vector(7 downto 0); -- From the switches
		  key_attempts: in std_logic_vector(3 downto 0);
		  unlocked:  out std_logic;	-- Showed at the leds bench
		  remaining: out std_logic_vector(6 downto 0));-- 7 segments display	
end Pr2;

architecture Behavioral of Pr2 is
	
	-- Our padlock as finite state machine
	component padlock is
	port(rst:             in std_logic;
		  clk:             in std_logic;
		  keyAttempts:     in std_logic_vector(3 downto 0);
		  keyCombination:  in std_logic_vector(7 downto 0);
		  isUnlocked:     out std_logic;
		  lockedForever:  out std_logic;
		  attemptsLeft:   out std_logic_vector(3 downto 0));
	end component;
	
	-- To 7 segment converter
	component conv_7seg
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	-- Debouncer for the push button
	component debouncer
	port(rst:              in std_logic;
        clk:              in std_logic;
        x:                in std_logic;
        xDeb: 				 out std_logic;
        xDebFallingEdge: out std_logic;
        xDebRisingEdge:  out std_logic);
	end component;
	
	-- Divider for the oscilant output
	component divisor is
    port (
        rst: in STD_LOGIC;
        clk_entrada: in STD_LOGIC; -- reloj de entrada de la entity superior
        clk_salida: out STD_LOGIC -- reloj que se utiliza en los process del programa principal
    );
	end component;
	
	-- Signals for the conexions:
	signal pbDebounced: std_logic;
	signal binaryAttemptsLeft: std_logic_vector(3 downto 0);
	signal dividerOutput: std_logic;
	signal isLockedForever: std_logic;
	signal isUnlocked: std_logic;
	
begin
	pushButton: debouncer port map
	(
		rst 				 => rst,
      clk 				 => clk,
      x	 				 => check,
      xDebFallingEdge => pbDebounced
		
		-- CAUTIION! There are outputs not conected!
	);
	fsm: padlock port map
	(
		rst 				 => rst,
		clk 				 => pbDebounced, -- Clock for the padlock is the debounced push button
		keyAttempts     => key_attempts,
		keyCombination  => key_entry,
		isUnlocked 		 => isUnlocked,
		lockedForever   => isLockedForever,
		attemptsLeft 	 => binaryAttemptsLeft
	);
	decimalDigit: conv_7seg port map
	(
		x 			=> binaryAttemptsLeft,
		display 	=> remaining
	);
	oscilador: divisor port map
	(
		rst => rst,
		clk_entrada => clk,
		clk_salida => dividerOutput
	);
	
	unlocked <= isUnlocked or (isLockedForever and dividerOutput);

end Behavioral;

