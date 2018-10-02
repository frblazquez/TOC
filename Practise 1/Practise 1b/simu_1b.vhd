-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Test for the 4 bits register designed.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
 
 
ENTITY simreg IS
END simreg;
 
ARCHITECTURE behavior OF simreg IS 
 
-- Declaración del componente que vamos a simular
 
    COMPONENT register4bits
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
			   load: IN  std_logic;
         I   : IN  std_logic_vector(3 downto 0);
         O   : OUT std_logic_vector(3 downto 0));
    END COMPONENT;

--Entradas
    signal rst : std_logic;
    signal clk : std_logic;
    signal I   : std_logic_vector(3 downto 0);
	  signal load: std_logic;
		
--Salidas
    signal O : std_logic_vector(3 downto 0);
   
--Se define el periodo de reloj 
    constant clk_period : time := 50 ns;
 
BEGIN
 
-- Instanciacion de la unidad a simular 

   uut: register4bits PORT MAP (
          rst => rst,
          clk => clk,
			    load => load,
          I => I,
          O => O
        );

-- Definicion del process de reloj
reloj_process :process
   begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;
 

--Proceso de estimulos
stim_proc: process
   begin		
-- Se mantiene el rst activado durante 45 ns.
	rst<='1';
	load <= '0';
	I<="0000";
      wait for 45 ns;
-- Dejamos de resetear	
	rst<='0';
	load <= '0';
	I<="0000";
      wait for 50 ns;	
-- Cargamos el valor "1101" en el registro
	rst<='0';
	load <= '1';
	I<="1101";
      wait for 50 ns;	
-- Mantenemos el valor durante 100 ns
	rst<='0';
	load <= '0';
	I<="0000"; 
      wait for 100 ns;	
-- Cargamos el valor "0011" en el registro 
	rst<='0';
	load <= '1';
	I<="0011"; 
      wait for 50 ns;	
-- Mantenemos el valor para siempre
	rst<='0';
	load <= '0';
	I<="0000"; 
      wait;	
end process;

END;