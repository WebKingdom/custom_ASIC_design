-------------------------------------------------------------------------
-- Dawood Ghauri (DG)
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- addsub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide adder/subtractor
-- using structural VHDL, generics, and generate statements.
--
-- NOTES:
-- 2/22/2021 by DG: Initial Creation.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- Creation of adder/subtractor entity with valid port descriptions.
entity addsub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_XMain          : in std_logic_vector(N-1 downto 0);
	   i_YMain          : in std_logic_vector(N-1 downto 0);	
	   nAdd_Sub     	: in std_logic;
       o_Sum          	: out std_logic_vector(N-1 downto 0);
	   o_Carry          : out std_logic;
	   o_Overflow		: out std_logic);

end addsub_N;

architecture structural of addsub_N is
  
  -- N-bit wide full adder component
  component fulladder_N is
	  port(i_X          : in std_logic_vector(N-1 downto 0);
		   i_Y          : in std_logic_vector(N-1 downto 0);	
	       i_Cin        : in std_logic;
           o_S          : out std_logic_vector(N-1 downto 0);
	       o_C          : out std_logic;
		   o_CNminus1	: out std_logic);
  end component;
  
  -- N-bit wide 2-to-1 MUX component
  component mux2t1_N is
	  port(i_S          : in std_logic;
           i_D0         : in std_logic_vector(N-1 downto 0);
           i_D1         : in std_logic_vector(N-1 downto 0);
           o_O          : out std_logic_vector(N-1 downto 0));
  end component;
  
  -- N-bit wide one's complementor (inverter) component
  component onescomp_N is
	  port(i_D          : in std_logic_vector(N-1 downto 0);
           o_invOut     : out std_logic_vector(N-1 downto 0));

  end component;
  
  -- XOR gate component to be used for overflow detection (future)
  component xorg2 is
	  port(i_A          : in std_logic;
           i_B          : in std_logic;
           o_F          : out std_logic);
  end component;

  signal muxOUTtoY		: std_logic_vector(N-1 downto 0);
  signal invOUTtoMuxD1	: std_logic_vector(N-1 downto 0);
  signal s_CNminus1		: std_logic;
  signal s_CN			: std_logic;
  
  

begin
     
  INV0:		onescomp_N
		port map(i_D		=> i_YMain,
				 o_invOut	=> invOUTtoMuxD1);  
  
  MUX0:		mux2t1_N
		port map(i_S		=> nAdd_Sub,
				 i_D0		=> i_YMain,
				 i_D1		=> invOUTtoMuxD1,
				 o_O		=> muxOUTtoY);	

  RCA0:		fulladder_N
		port map(i_X		=> i_XMain,
				 i_Y		=> muxOUTtoY,
				 i_Cin		=> nAdd_Sub,
				 o_S		=> o_Sum,
				 o_C		=> s_CN,
				 o_CNminus1	=> s_CNminus1);

  XOR0:		xorg2
		port map(i_A		=> s_CN,
				 i_B		=> s_CNminus1,
				 o_F	 	=> o_Overflow);
				 
 
  o_Carry	<= 	s_CN;
end structural;
