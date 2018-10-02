-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise one, optional part. Using the 
-- components designed for this practise, create a 4 bits
-- counter.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---------------------------------------------------------------------
entity counter4bits is

port(clk:           in  std_logic;
	  countCounter: in  std_logic;
     resetCounter:  in  std_logic;
     result:        out std_logic_vector(3 downto 0));

end counter4bits;
---------------------------------------------------------------------

architecture Behaivoral of counter4bits is

constant UNO: std_logic_vector(3 downto 0) := "0001";

component sumador4b is
	port(A, B: in  std_logic_vector(3 downto 0);
		    C: out std_logic_vector(3 downto 0));
end component; 

component register4bits is 
	port(rst, clk, load: std_logic;
		  I: in  std_logic_vector(3 downto 0);
		  O: out std_logic_vector(3 downto 0));
end component;

component divisor is
    port (
        rst: in STD_LOGIC;
        clk_entrada: in STD_LOGIC;
        clk_salida: out STD_LOGIC 
    );
end component;

signal registerOut: std_logic_vector(3 downto 0);
signal registerIn:  std_logic_vector(3 downto 0);
signal count: std_logic_vector(3 downto 0);
signal clockGood: std_logic;

begin

DivisorUnit: divisor port map(
	rst => resetCounter,
	clk_entrada => clk,
	clk_salida => clockGood);

Sumador: sumador4b port map(
	A => UNO,
	B => registerOut,
	C => registerIn);

Registro: register4bits port map(
	rst => resetCounter,
	clk=> clockGood,
	load=> countCounter,
	I=> registerIn,
	O=> registerOut);
	
result <= registerOut;

end Behaivoral;