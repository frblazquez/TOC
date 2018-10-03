-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Multiplier by 3 desing with VHDL.

library IEEE;
use ST_LOGIC_1164.ALL;
use STD_LOGIC_ARITH.All;
use STD_LOGIC_UNSIGNED.ALL;

entity multiplierBy3 is
port(input:    in  std_logic_vector(2 downto 0);
     output:   out std_logic_vector(3 downto 0);
     overflow: out std_logic);
end multiplierBy3;

architecture behaviour of multiplierBy3 is
    -- Signals and constant values that we are needing
    constant three: std_logic_vector(1 downto 0) := "11";
    signal  result: std_logic_vector(4 downto 0);
begin
    -- What this circuit has to do
    result   <= three*input;
    overflow <= result(4);
    output   <= result(3 downto 0);
end behaviour;
