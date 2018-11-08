-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Multiplier designed from and ASM diagram.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MultiplierASM is
	port(rst: in  std_logic;
		  clk: in  std_logic;
		  ini: in  std_logic;
		  A:   in  std_logic_vector(3 downto 0);
		  B:   in  std_logic_vector(3 downto 0);
		  Z:   out std_logic_vector(7 downto 0);
		  fin: out std_logic);
end MultiplierASM;

architecture Behavioral of MultiplierASM is
	
	component controller
	port (clk: 	 in std_logic;
			reset: in std_logic;
			init:  in std_logic;
			zero:  in std_logic;
			control: out std_logic_vector (4 downto 0);
			ended: 	out std_logic);
	end component;
	
	component dataPath
	port (clk:     in  std_logic;
			reset:   in  std_logic;
			a_in:    in  std_logic_vector(7 downto 0);
			b_in:    in  std_logic_vector(7 downto 0);
			control: in  std_logic_vector (4 downto 0);
			zero:    out std_logic;
			result:  out std_logic_vector (7 downto 0));
	end component;

	signal Aextended: std_logic_vector(7 downto 0) := (others=>'0');
	signal Bextended: std_logic_Vector(7 downto 0) := (others=>'0');
	signal ControlSg: std_logic_vector(4 downto 0) := (others=>'0');
	signal endBit: std_logic;
	signal zeroBit: std_logic;
	
begin
	
	Aextended(3 downto 0) <= A;
	Bextended(3 downto 0) <= B;
	
	Control: controller port map
	(
		clk     => clk,
		reset   => rst,
		init    => ini, 
		zero    => zeroBit,
		control => controlSg,
		ended   => endBit
	);
	
	Data: dataPath port map
	(
		clk    => clk,
		reset  => rst,
		a_in   => Aextended,
		b_in   => Bextended,
		control=> controlSg,
		zero   => zeroBit,
		result => Z
	);
	
	fin <= endBit;

end Behavioral;

