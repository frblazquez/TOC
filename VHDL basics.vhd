-- Francisco Javier Blázquez Martínez ~ frblazqu@ucm.es
--
-- Double degree in Mathematics-Computer engineering.
-- Complutense university, Madrid.
--
-- Description: Basic VHDL examples and reference.
-------------------------------------------------------

VHDL is a hardware description language, it's usefull to
desing hardware and test it without needing to implement
it. Don't think like software and don't think of VHDL as
an imperative programming language, these are not instruc-
tions, these are hardware descriptions and hardware comp-
ponents.

When simulating in VHDL, the instructions writtens simulate
the functionality of a circuit, they don't execute sequen-
tially. In an VHDL simulation the instructions will be re-
peated until a stable state is reachen.


1.- STRUCTURE OF AN VHDL MODEL:

-- ENTITY, External description of the circuit:
entity name is
generic (parameters);
port (input and output ports);
end name;

-- ARCHITECTURE, Description of it's functionality:
architecture arch_name of entity_name is
-- our types
-- signals
-- components
begin
-- description code
-- components
-- process clause
process (lista de sensibilidad)
begin
-- código de descripción
end process;
end arch_name;

1.1.- EXAMPLE:

-- This circuit will receive a number (n) from 0 to 7 and will
-- return 3*n but in a range from 0 to 15 and will indicate 
-- whether there was overflow or not.

library IEEE;					-- General library
use ieee.std_logic_1164.all;	-- To use std_logic
use ieee.std_logic_unsigned.all;-- Binary vectors as unsigned
use ieee.std_logic_arith.all;	-- To use arith. operations

entity multiplierBy3 is
port(input:    in  std_logic_vector(2 downto 0);
	 output:   out std_logic_vector(3 downto 0);
	 overflow: out std_logic);
end multiplierBy3;

architecture behaviour of multiplierBy3 is
	constant three: std_logic_vector(1 downto 0) := "11";
	signal result:  std_logic_vector(4 downto 0);
begin
	result <= three*input;
	overflow <= result(4);
	output <= result(3 downto 0);
end behaviour;

If this is the first time you see an VHDL design you might be
a bit impressed. Now we'll see VHDL elements and everything
will be clearer.

2.- VHDL ELEMENTS:

2.1.- Signals and Constants:
	They act just like wires or conections in our circuit.

	signal sig_name: type;
	signal sig_name: tipe := defaultValue;
	signal output: std_logic_vector(3 downto 0) := "0000";

	constant const_name: type := value;
	constant UNO: std_logic := '1';

2.2.- Variables:
	They store a value, we will evite them because they need
	latches and don't generate combinational circuits. Try to
	use them just to control the loops iterations.

	variable var_name: type;
	variable var_name: type := defaultValue;
	variable i: std_logic_vector(25 downto o) := (others=> '0');

2.3.- Concurrent sentences:
	They should never appear inside a process clause. They are
	pure combinational logic to take a value for a signal. They
	also should always have a default value to avoid sequential
	hardware.

	-- With-Select-When sentences:
	with signal_name select
	output_signal <= value_1 when signal_value_1,
					 value_2 when signal_value_2,
					 .		.		.		.
					 .		.		.		.
					 value_n when signal_value_n,
					 default_value when other;

	-- When-Else sentences:
	output_signal <= value_1 when condition_1 else
					 value_2 when condition_2 else
					 .		.		.		.
					 .		.		.		.		
					 value_n when condition_n else
					 default_value;

2.4.- Process sentences:
	
	process(sensibility list)
	begin
	-- Sequential  sentences
	-- Conditional sentences
	end process;

	The instructions inside a process clause will be executed
	when any of the variables changes it's value. In these 
	clauses the order of the instructions really matter.

2.5.- Conditional sentences:
	These should always be inside a process (and the decision
	variables should logically be inside the process sensibili-
	ty list). They should always have a default case. These are:

	-- If else sentences:
	if cond_l then
	  -- statements
	elsif cond-n then
	  -- statements
	else
	  -- statements
	end if;

	-- Sitch expression:
	case expression is
		when choice_l => ... -- statements;
		when choice_n => ... -- statements;
		when others =>   ... -- statements;
	end case;

2.6.- Loops:
	
	[label:] loop
	 -- sequence-of-statements
	 -- use exit statement to get out
	end loop [label];

	[label:] for var in range loop
	-- sequence-of-statements
	end loop [label];

2.7.- Wait sentences:
	
	wait for <time delay>             -- 100 ns
	wait until <condition>			  -- a > '0'
	wait on <sensitive clause, event> -- Event

2.8.- Atributes:
	Given a signal S, we might be interested in knowing whether
	S has changed it's value this simulation cycle, and many
	other properties. We find out that this way:

	S'event       = true if S has changed it's value this cycle.
	S'last_value  = previous value S had.
	S'last_active = time since S was active.

2.9.- Data types:
	Integer, natural, real, time, resistance, bit, bit vector,
	(better to use std_logic and std_logic_vector), boolean, character.

	To define our owns types, we can use these instructions:

	tyme enum_name   is (S0, S1, S2, S3); -- Enumerated types
	type range_name  is range 0 to 9;	  -- Range types
	type record_name is 				  -- Structures
		field_1: type;
		field_2: type;
		...
		field_n: type;
	end record; 
	type array_name  is (n downto 0) of type;

2.10.- Operators:
	+,-,*,/,and,or,nand,xor...
	** for the exponenciation.
	%  for the module operator.

2.11.- Components:
	Components are modules, circuits that we defined and implemented
	before, apart, possibly in other files and project but modules that
	we want to use in our circuit. We have to declare them before the
	begin of the architecture.

	-- This declaration has to match the entity declaration in the file
	-- where it's implemented. The best way of doing this is copying it.
	component comp_name
		port(A: in  std_logic;	-- The type is just orientative and
			 B: in  std_logic;	-- it's just given to see how to 
			 C: out std_logic); -- initialize the component.
	end component;

	After the begin of the architecture we'll need to conect our comp-
	onent. In order to do this we have to follow this schema. We also 
	can initialize more than one component in our design.

	name: com_name port map(
		A => signal_a,
		B => signal_b,
		C => signal_c);

2.12.- Packages:
	-- Pending. Not really important at this level.

2.13.- Generic parameters in VHDL:
	Before the ports description in an entity, we can define parameters
	with a generic value. If we want to desing a decoder, we don't need
	to desing a decoder for each number of bites at the input. We can do
	it generic using this easy schema. 

	generic(generic_1: type := defaultValue,
		    generic_2: type);

    Giving a default value is not strictly necessary but it's highly re-
    commended. This helps when the program has to implement the desing.

3.- TESTBENCHS, SIMULATING TEST CASES:
	
	To see whether our circuit works or not we create an empty entity
	and in it's architecture we instanciate a component for testing.
	Then we give to the input signals test values and we can check the
	correction of the output executing the simulation.

	We can also do automatic testbenchs and use assert expresions to
	check the correction automatically.
