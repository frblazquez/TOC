-- Francisco Javier Blzquez Martnez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: 
-- Control unit for the MIPS processor.

library IEEE;
use IEEE.std_logic_1164.all;

entity unidadDeControl is
port( clk		: in  std_logic;
		rst_n		: in  std_logic;
		control	: out std_logic_vector(18 downto 0);
		Zero		: in  std_logic;
		zero_inm : in  std_logic;
		op			: in  std_logic_vector(5 downto 0);
		modo		: in  std_logic;
		siguiente: in  std_logic);
end unidadDeControl;

architecture unidadDeControlArch of unidadDeControl is

  signal control_aux : std_logic_vector(18 downto 0);
  alias PCWrite	: std_logic is control_aux(0);
  alias IorD 		: std_logic is control_aux(1);
  alias MemWrite	: std_logic is control_aux(2);
  alias MemRead 	: std_logic is control_aux(3);
  alias IRWrite 	: std_logic is control_aux(4);
  alias RegDst 	: std_logic is control_aux(5);
  alias MemtoReg 	: std_logic_vector(2 downto 0) is control_aux(8 downto 6);
  alias RegWrite 	: std_logic is control_aux(9);
  alias AWrite 	: std_logic is control_aux(10);
  alias BWrite 	: std_logic is control_aux(11);  
  alias ALUScrA 	: std_logic is control_aux(12);
  alias ALUScrB 	: std_logic_vector(1 downto 0) is control_aux(14 downto 13);
  alias OutWrite 	: std_logic is control_aux(15);
  alias ALUop 		: std_logic_vector(1 downto 0) is control_aux(17 downto 16);
  alias PCMux     : std_logic is control_aux(18);
  
  TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);
  SIGNAL currentState, nextState: states;

begin

	control <= control_aux;

  stateGen:
  PROCESS (currentState, op , zero, zero_inm, modo, siguiente)
  BEGIN

    nextState <= currentState;
	 control_aux <= (OTHERS=>'0');
		  
    CASE currentState IS
		
		WHEN S0 =>
			PCWrite <= '1';
			MemRead <= '1';
			ALUScrB <= "01";
			nextState <= S1;
		 --ALUSrcA <= '0';
		 --IorD    <= '0';
			
		WHEN S1 =>
			IRWrite <= '1';
			if (modo = '0' or (modo = '1' and siguiente = '1')) then
				nextState <= S2;
			end if;
			
		WHEN S2 =>
			AWrite <= '1';
			BWrite <= '1';
			
			if    (op = "000000") then -- arith-logic
				nextState <= S8;
			elsif (op = "100011") then -- lw
				nextState <= S3;
			elsif (op = "101011") then -- sw
				nextState <= S6;
			elsif (op = "000100") then -- beq
				nextState <= S10;
			elsif (op = "010000") then -- mv #inmed
				nextState <= S12;
			elsif (op = "010010") then -- mv rt, rs
				nextState <= S13;
			elsif (op = "000010") then -- jump
				nextState <= S14;
			elsif (op = "010001") then -- lectura switches
				nextState <= S15;
			end if;
		
		WHEN S3 =>
			ALUScrA <= '1';
			ALUScrB <= "10";
			OutWrite <= '1';
			nextState <= S4;
			
		WHEN S4 =>
			MemRead <= '1';
			IorD <= '1';
			nextState <= S5;
		
		WHEN S5 =>
			MemtoReg <= "001";
			RegWrite <= '1';
			nextState <= S0;
		
		WHEN S6 =>
			ALUScrA <= '1';
			ALUScrB <= "10";
			OutWrite <= '1';
			nextState <= S7;
			
		WHEN S7 =>
			MemWrite <= '1';
			IorD <= '1';
			nextState <= S0;
		
		WHEN S8 =>
			ALUScrA <= '1';
			ALUOp <= "10";		
		-- ALUOp=="00" ~ +
		-- ALUOp=="01" ~ -
		-- ALUOp=="10" ~ funct bits deciden
			OutWrite <= '1';
			nextState <= S9;
		
		WHEN S9 =>
			RegDst <= '1';
			RegWrite <= '1';
			nextState <= S0;
			
		WHEN S10 =>
			ALUScrA <= '1';
			ALUOp <= "01";
			if (Zero = '0') then
				nextState <= S0;
			else
				nextState <= S11;
			end if;
			
		WHEN S11 =>
			PCWrite <= '1';
			ALUScrB <= "11";
			nextState <= S0;
		 --PCMux <= '0';
		 
		WHEN S12 =>
	    --RegDst => '0';
		   MemToReg  <= "010";
			RegWrite  <= '1';
			nextState <= S0;
		
		WHEN S13 => 
	    --RegDst => '0';
		   MemToReg  <= "011";
			RegWrite  <= '1';
			nextState <= S0;
		
		WHEN S14 =>
			PCMux <= '1';
			PCWrite <= '1';
			nextState <= S0;
		
		WHEN S15 =>
			
			if(zero_inm='0') then
				MemtoReg <= "100";
			else
				MemtoReg <= "101";
			end if;
			
			regWrite <= '1';
			nextState <= S0;

    END CASE;
  END PROCESS stateGen;

  state:
  PROCESS (rst_n, clk)
  BEGIN
	 IF (rst_n = '0') THEN
		currentState <= S0;
    ELSIF RISING_EDGE(clk) THEN
		currentState <= nextState;
    END IF;
  END PROCESS state;

end unidadDeControlArch;