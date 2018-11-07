-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- TOC practise 4. Multiplier designed from and ASM diagram.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Practise4 is
	port(rst:   in std_logic;
	     clk:   in std_logic;
		  start: in std_logic;									-- This bit indicates when we can start
		  op1:   in std_logic_vector(3 downto 0);			-- First operating
		  op2:   in std_logic_vector(3 downto 0);			-- Second operating
		  HxResult1: out std_logic_vector(6 downto 0);	-- The result goes to 2 7-segments-leds
		  HxResult2: out std_logic_vector(6 downto 0);  -- (represents hexadecimal digits)
		  ended:     out std_logic);							-- This tell us if the result is correct
end Practise4;

architecture Behavioral of Practise4 is
-- COMPONENTS NEEDED:
	
	-- 4x4 bit Multiplier
	component MultiplierASM
	port(rst: in  std_logic;
		  clk: in  std_logic;
		  ini: in  std_logic;
		  A:   in  std_logic_vector(3 downto 0);
		  B:   in  std_logic_vector(3 downto 0);
		  Z:   out std_logic_vector(7 downto 0);
		  fin: out std_logic);
	end component;
	
	-- 4bit to Hexadecimal 7-segment converter
	component conv_7seg
		Port (x:         in std_logic_vector(3 downto 0);
				display : out std_logic_vector(6 downto 0));
	end component;
	
	-- Debouncer for the push buttons
	component debouncer
		port(rst: IN std_logic;
			  clk: IN std_logic;
			  x: IN std_logic;
			  xDeb: OUT std_logic;
			  xDebFallingEdge: OUT std_logic;
			  xDebRisingEdge: OUT std_logic);
	end component;
	
-- SIGNALS NEEDED:
signal startDebounced: std_logic;
signal multiplierResult: std_logic_vector(7 downto 0);

begin

iniDebounced: debourcer port map
(
	rst  <= rst,
	clk  <= clk,
	x    <= start,
	xDeb <= startDebounced
);

multiplier: MultiplierASM port map
(
	rst <= rst,
	clk <= clk,
	ini <= startDebounced,
	A   <= op1,
	B   <= op2,
	Z   <= multiplierResult,
	fin <= ended
);
	
conv1: conv_7seg port map
(
	x       <= multiplierResult(3 downto 0),
	display <= HxResult1
);

conv2: conv_7seg port map
(
	x       <= multiplierResult(7 downto 4),
	display <= HxResult2
);

end Behavioral;