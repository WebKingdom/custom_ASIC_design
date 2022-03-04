-------------------------------------------------------------------------
-- Dawood Ghauri (DG)
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- fulladder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide ripple carry adder
-- using structural VHDL, generics, and generate statements.
--
-- NOTES:
-- 2/20/2021 by DG: Initial Creation.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X          : in std_logic_vector(N-1 downto 0);
	   i_Y          : in std_logic_vector(N-1 downto 0);	
	   i_Cin        : in std_logic;
       o_S          : out std_logic_vector(N-1 downto 0);
	   o_C          : out std_logic;
	   o_CNminus1	: out std_logic);

end fulladder_N;

architecture structural of fulladder_N is

  component fulladder is

	port(i_A			: in std_logic;
		 i_B			: in std_logic;
		 i_Cin			: in std_logic;
		 o_S			: out std_logic;
		 o_C			: out std_logic);
		 
  end component;
  
  signal c_inter		: std_logic_vector(N downto 0);

begin

  c_inter(0) 	<= i_Cin;
  o_C 			<= c_inter(N);
  o_CNminus1 	<= c_inter(N-1);
  
  -- Instantiate N adder instances.
  G_NBit_Adder: for i in 0 to N-1 generate
    Adder1: fulladder port map(
              i_A      => i_X(i),  
			  i_B      => i_Y(i),
			  i_Cin    => c_inter(i),
			  o_S      => o_S(i),
              o_C      => c_inter(i+1)); 

  end generate G_NBit_Adder;
  
end structural;
