-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Data path for the ASM multiplier.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dataPath is
	port (clk:     in  std_logic;
		  reset:   in  std_logic;
		  a_in:    in  std_logic_vector(7 downto 0);
		  b_in:    in  std_logic_vector(7 downto 0);
		  control: in  std_logic_vector (4 downto 0);
		  zero:    out std_logic;
		  result:  out std_logic_vector (7 downto 0));
end dataPath;

architecture Behavioral of dataPath is

	-- n bits register
	component register_n
		generic (n: natural := 8);
		port (clk:  in  std_logic;
			  rst:  in  std_logic;
			  load: in  std_logic;
			  din:  in  std_logic_vector(n-1 downto 0);
			  dout: out std_logic_vector(n-1 downto 0));
	end component;
	
	signal controlAux: std_logic_vector(4 downto 0) := (others=>'0');
	alias load_a: std_logic is controlAux(0);
	alias load_n: std_logic is controlAux(1);
	alias load_r: std_logic is controlAux(2);
	alias mux_n:  std_logic is controlAux(3);
	alias rst_r:  std_logic is controlAux(4);
	
	constant UNO: unsigned := "1";
	signal regAout, regAin: std_logic_vector(7 downto 0);
	signal regNout, regNin: std_logic_vector(7 downto 0);
	signal regRout, regRin: std_logic_vector(7 downto 0);
	signal muxNout: std_logic_vector(7 downto 0) := (others=>'0');
	signal regRrst: std_logic;
	signal regNminus: std_logic_vector(7 downto 0);
	
begin
	
	-- Signals:
	controlAux <= control;
	regRrst    <= reset or rst_r;
	regRin     <= std_logic_vector(unsigned(regAout) + unsigned(regRout));
	regNminus  <= std_logic_vector(unsigned(regNout) - UNO);
	
	-----------------------------------------------------------------------
	---------------------- 2to1 Multiplexor -------------------------------
	with mux_n select
	muxNout <=  b_in      when '1',
				regNminus when others;
	-----------------------------------------------------------------------
					
	-- Registers:
	regA: register_n port map(clk,reset,  load_a,a_in,   regAout);
	regN: register_n port map(clk,reset,  load_n,muxNout,regNout);
	regR: register_n port map(clk,regRrst,load_r,regRin, regRout);
	
	-- Outputs:
	result <= regRout;
	
	with regNout select 
	zero <=	'1' when "00000000", 
			'0' when others;

end Behavioral;

