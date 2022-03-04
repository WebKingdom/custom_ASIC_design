-------------------------------------------------------------------------
-- Dawood Ghauri (DG)
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1-bit wide 2:1
-- mux using structural VHDL.
--
--
-- NOTES:
-- 2/10/2021 by DG: Initial Creation.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

	port(i_D0			: in std_logic;
		 i_D1			: in std_logic;
		 i_S			: in std_logic;
		 o_O			: out std_logic);
		 
end mux2t1;

architecture structural of mux2t1 is

	component andg2 is
	
	  port(i_A          : in std_logic;
		   i_B          : in std_logic;
		   o_F          : out std_logic);

	end component;
	
	component invg is
	  port(i_A          : in std_logic;
		   o_F          : out std_logic);
	   
	end component;
	
	component org2 is
	
	  port(i_A          : in std_logic;
           i_B          : in std_logic;
		   o_F          : out std_logic);
		   
	end component;
	
	-- Signal to carry NOT i_S
	signal s_NS			: std_logic;
	-- Signal to carry NOT i_S ANDed with i_D0
	signal s_NSD0		: std_logic;
	-- Signal to carry i_S ANDed with i_D1
	signal s_SD1		: std_logic;
	
begin

	NGATE: invg 
		port map(i_A 		=> i_S,
				 o_F		=> s_NS);
				 
	ANDGATE0: andg2
		port map(i_A		=> s_NS,
				 i_B		=> i_D0,
				 o_F		=> s_NSD0);
				 
	ANDGATE1: andg2
		port map(i_A		=> i_S,
				 i_B		=> i_D1,
				 o_F		=> s_SD1);
				 
	ORGATE: org2
		port map(i_A		=> s_NSD0,
				 i_B		=> s_SD1,
				 o_F		=> o_O);
				 
end structural;

