-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- MIPS processor design. There are some MIPS' allowed operations
-- left. This is a basic design done for TOC subject practise 6.

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPSMulticiclo is
	port(clk			: in  std_logic;
		  rst_n		: in  std_logic;
		  displayD	: out std_logic_vector(6 downto 0);
		  displayI	: out std_logic_vector(6 downto 0);
		  modo		: in 	std_logic;
		  siguiente	: in 	std_logic;
		  displayS 	: out std_logic_vector(6 downto 0));
end MIPSMulticiclo;

architecture MIPSMulticicloArch of MIPSMulticiclo is

	component unidadDeControl is
	port(clk			: in  std_logic;
		  rst_n		: in  std_logic;
		  control	: out std_logic_vector(15 downto 0);
		  Zero		: in  std_logic;
		  op			: in  std_logic_vector(5 downto 0);
		  modo		: in  std_logic;
		  siguiente	: in  std_logic);
	end component;

	component rutaDeDatos is
	port(clk		 : in  std_logic;
		  rst_n	 : in  std_logic;
		  control : in  std_logic_vector(15 downto 0);
		  Zero	 : out std_logic;
		  op		 : out std_logic_vector(5 downto 0);
		  R3		 : out std_logic_vector(31 downto 0);
		  PCout	 : out std_logic_vector(31 downto 0));
	end component;
	
	component DCM_100MHz_10MHz
	port (CLKIN_IN  : in    std_logic; 
			CLKDV_OUT : out   std_logic; 
			CLK0_OUT  : out   std_logic);
	end component;
  
	component conv_7seg
	port (x 			:  in  std_logic_vector(3 downto 0);
			display 	: out  std_logic_vector(6 downto 0));
	end component;

	component debouncer
	  generic(FREQ   : natural := 10000;  	-- frecuencia de operacion en KHz
				 BOUNCE : natural := 100);		-- tiempo de rebote en ms
	  port(rst					: in  std_logic;
			 clk					: in  std_logic;
			 x						: in  std_logic;
			 xDeb					: out	std_logic;
			 xDebFallingEdge	: out std_logic;
			 xDebRisingEdge	: out std_logic);
	END component;
  
   signal clk_10MHz : std_logic;
	signal control : std_logic_vector(15 downto 0);
	signal Zero	: std_logic;
	signal op : std_logic_vector(5 downto 0);
	signal R3 : std_logic_vector(31 downto 0);
	signal PC : std_logic_vector(31 downto 0);
	signal PCDecrementado : std_logic_vector(31 downto 0);
	signal siguienteDebouncer : std_logic;

begin

	reloj : DCM_100MHz_10MHz port map 
	(
		CLKIN_IN  => clk, 
		CLKDV_OUT => clk_10MHz, 
		CLK0_OUT  => open
	);

	eliminadorRebotesModo : debouncer port map
	(
		rst		 		 => rst_n, 
		clk	 			 => clk_10MHz, 
		x 					 => siguiente, 
		xDeb 				 => open, 
		xDebFallingEdge => open, 
		xDebRisingEdge  => siguienteDebouncer
	);
	
	UC : unidadDeControl port map
	(
		clk 		 => clk_10MHz, 
		rst_n 	 => rst_n, 
		control 	 => control, 
		Zero 		 => Zero, 
		op 		 => op, 
		modo 		 => modo, 
		siguiente => siguienteDebouncer
	);
		
	RD: rutaDeDatos port map
	(
		clk 		=> clk_10MHz, 
		rst_n 	=> rst_n, 
		control 	=> control, 
		Zero 		=> Zero, 
		op 		=> op, 
		R3 		=> R3, 
		PCout 	=> PC
	);

	displayIzquierdo: conv_7seg port map
	( 
		x 			=> R3(7 downto 4), 
		display 	=>  displayI
	);

	displayDerecho: conv_7seg port map
	(
		x 			=> R3(3 downto 0), 
		display 	=>  displayD
	);
	
	displaySuperior: conv_7seg port map
	( 
		x 			=> PCDecrementado(3 downto 0), 
		display 	=>  displayS
	);
	
	PCDecrementado <= std_logic_vector(to_unsigned(to_integer(unsigned(PC(31 downto 2))) - 1, 32));

end MIPSMulticicloArch;