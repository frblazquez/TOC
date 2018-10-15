-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise 2, lock using a finite state machine.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity practise2 is
port(
	  reset:       in std_logic;							-- Go back to initial state
	  clk: 	      in std_logic;							-- For the debouncer
	  capture_key: in std_logic;							-- Confirm key
	  key_input:   in std_logic_vector(7 downto 0);	-- Key to introduce
	  
	  unlocked:   out std_logic;							-- 1 if its unlocked
	  tries_left: out std_logic_vector(6 downto 0)	-- Tries left (unsigned binary digit)
	  );
end practise2;

architecture Behavioral of practise2 is

-- Debouncer for the push buttons
component debouncer
  port(
    rst: IN std_logic;
    clk: IN std_logic;
    x:   IN std_logic;
    xDeb: OUT std_logic;
    xDebFallingEdge: OUT std_logic;
    xDebRisingEdge: OUT std_logic
  );
end component;

-- From binary to seven segments converter
component conv_7seg 
    port ( x :       in   STD_LOGIC_VECTOR (3 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

-- Any component left?

-- Types:
type states is (Si, S1, S2, S3, Sf);

-- Signals:
signal attemptsLeftBinary:  std_logic_vector(3 downto 0) := (others=>'0');
signal attemptsLeft7seg:    std_logic_vector(6 downto 0);
signal debouncedCaptureKey: std_logic;
signal storedKey: std_logic_vector(7 downto 0);
signal nextKey:   std_logic_vector(7 downto 0);
signal actualState: states := Si;
signal nextState: states := Sf;
signal nextAttemptsBinary:  std_logic_vector(3 downto 0);
signal isUnlocked: std_logic;

begin
toDecimalDigit: conv_7seg port map
(
	x       => attemptsLeftBinary,
	display => attemptsLeft7seg
);

pushButtonNextState: debouncer port map
(
	rst => reset,
	clk => clk,
	x   => capture_key,
	xDebRisingEdge => debouncedCaptureKey
	
	-- CAUTION! There are not conected outputs!
);

process(debouncedCaptureKey, reset)
begin

if(reset='1') then
	actualState <= Si;
	
elsif(debouncedCaptureKey'event and debouncedCaptureKey='1') then
	actualState  <= nextState;
	storedKey    <= nextKey;
	
end if;

end process;

process(actualState, key_input)
begin

nextState <= Si;
nextAttemptsBinary <= attemptsLeftBinary - "0001";
nextKey <= storedKey;
isUnlocked <= '0';

case actualState is 
when Si =>
	
	nextState <= S1;
	nextKey <= key_input;
	nextAttemptsBinary <= "0011";
   isunlocked <= '1';
 
when S1 =>
	
	if(key_input /= storedKey) then
		nextState <= S2;
	end if;

when S2 =>
	
	if(key_input /= storedKey) then
		nextState <= S3;
	end if;

when S3 =>
	
	if(key_input /= storedKey) then
		nextState <= Sf;
	end if;

when others => 
	
	nextState <= Sf;
	nextAttemptsBinary <= "0000";

end case;

end process;

tries_left <= attemptsLeft7seg;
unlocked   <= isUnlocked;

end Behavioral;

