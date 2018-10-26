-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Practise one, part one. Test for the
-- 4bits adder.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

--entidad
 
ENTITY simsum IS
END simsum;
 
--arquitectura

ARCHITECTURE testbench_arch OF simsum IS 
 
-- Declaración del componente que vamos a simular

    COMPONENT sumador4b
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         C : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
--Entradas
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

--Salidas
   signal C : std_logic_vector(3 downto 0);
  
BEGIN
 
-- Instanciacion de la unidad a simular 
   uut: sumador4b PORT MAP (
          A => A,
          B => B,
          C => C
        );

-- Proceso de estimulos
stim_proc: process
   begin		
		A<="0000";
		B<="0000";
      wait for 100 ns;
		A<="0101"; 
		B<="0100";
      wait for 100 ns;
		A<="0000";
		B<="0111";
      wait for 100 ns;
		A<="0011";
		B<="1000";
      wait for 100 ns;
		A<="1011";
		B<="1111";
      wait for 100 ns;
		A<="1001";
		B<="0110";
      wait;
end process;

END testbench_arch;
