LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestBenchMIPSMulticiclo IS
END TestBenchMIPSMulticiclo;
 
ARCHITECTURE behavior OF TestBenchMIPSMulticiclo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	component MIPSMulticiclo
	port(clk			: in  std_logic;
		  rst_n		: in  std_logic;
		  displayD	: out std_logic_vector(6 downto 0);
		  displayI	: out std_logic_vector(6 downto 0);
		  modo		: in 	std_logic;
		  siguiente	: in 	std_logic;
		  sw_sup		: in  std_logic_vector(3 downto 0);
		  sw_ext		: in  std_logic_vector(3 downto 0);
		  displayS 	: out std_logic_vector(6 downto 0));
	end component;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
	signal modo: std_logic := '0';
	signal sig:  std_logic := '0';
	signal disp_R3_right: std_logic_vector(6 downto 0);
	signal disp_R3_left:  std_logic_vector(6 downto 0);
	signal disp_PC:       std_logic_vector(6 downto 0);
	signal sw_sup : std_logic_vector(3 downto 0) := (others=>'0');
	signal sw_ext : std_logic_vector(3 downto 0) := (others=>'0');

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPSMulticiclo port map
	(
		clk       => clk,
      rst_n     => rst_n,
		displayD  => disp_R3_right,
		displayI  => disp_R3_left,
		modo 		 => modo,
		siguiente => sig,
		sw_sup 	 => sw_sup,
		sw_ext  	 => sw_ext,
		displayS  => disp_PC
   );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process 
   stim_proc: process
   begin		
      -- hold reset state for 200 ns.
		rst_n <= '0';
      wait for 200 ns;
		
		sw_sup <= "0111";
		sw_ext <= "0011";
		rst_n <= '1';
      wait for 200 us;

		rst_n <= '0';
		wait for 200 ns;
		
		sw_ext <= "0111";
		sw_sup <= "0011";
		rst_n <= '1';
		wait for 200 us;
		
      -- insert stimulus here 
      wait;
   end process;

END;
