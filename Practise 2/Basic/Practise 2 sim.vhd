-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Simulation for the practise2 TOC

library IEEE;use IEEE.STD_LOGIC_1164.ALL;use IEEE.STD_LOGIC_ARITH.All;use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity padlockSim is
end padlockSim;

architecture Behavioral of padlockSim is
	
	-- Component under test:
	component Pr2
	port(rst: 	     in std_logic;	-- From a push button and asynchronous
		  clk: 	     in std_logic;	-- For the push button implementation
		  check:	     in std_logic; 	-- From push button (and throught debouncer)
		  key_entry:  in std_logic_vector(7 downto 0); -- From the switches
		  unlocked:  out std_logic;	-- Showed at the leds bench
		  remaining: out std_logic_vector(6 downto 0));-- 7 segments display	  
	end component;
	
	-- Signals:
	signal rst: std_logic;
	signal clk: std_logic := '0';
	signal pushButton: std_logic;
	signal key: std_logic_vector(7 downto 0);
	signal unlocked: std_logic;
	signal remaining: std_logic_vector(6 downto 0);
	
begin
	
	uut: Pr2 port map
	(
		rst <= rst,
		clk <= clk,
		check <= pushButton,
		key_entry <= key,
		unlocked <= unlocked,
		remaining <= remaining	
	);
	
	process 
	begin
		if(clk='1') then
			clk <= '0';
		else 
			clk <= '1';
		end if;
		
		wait for 50 ns;
	end process;
	
	process
	begin
		rst <= '0';
		wait for 25 ns;
		
		rst <= '1';
		
		-- Prueba 1, clave = "010101010"
		key <= "01010101";
		wait for 100 ns;
		
		key <= "00000000";	-- 2 intentos fallidos
		wait for 200 ns;
		
		key <= "01010101";	-- Acierto al tercero
		wait for 100 ns;
		
		-- Prueba 2, clave = "11111111"
		key <= "11111111";
		wait for 100 ns;
		
		key <= "01111111";	-- Intento fallido
		wait for 100 ns;
		
		key <= "11111111";	-- Clave correcta no capturada
		wait for 50 ns;
		key <= "11111110";	-- Intento fallido
		wait for 50 ns;
		
		key <= "01010101";	-- Tercer intento fallido, bloqueo indefinido
		wait for 100 ns;
		
		key <= "11111111";	-- Comprobación del bloqueo
		wait for 200 ns;
		
		rst <= '0';
		wait for 25 ns;
		
		rst <= '1';
		key <= "00001111";
		wait for 100 ns;
		
		wait;
	end process;


end Behavioral;


