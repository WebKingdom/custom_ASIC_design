-------------------------------------------------------------------------
-- Dawood Ghauri (DG)
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- fulladder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1-bit wide full adder
-- using structural VHDL.
--
--
-- NOTES:
-- 2/20/2021 by DG: Initial Creation.
-- 2/23/2021 by DG: Fatal error correction. Derived o_S equation 
-- 					resulted in wrong structural mappings.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is

	port(i_A			: in std_logic;
		 i_B			: in std_logic;
		 i_Cin			: in std_logic;
		 o_S			: out std_logic;
		 o_C			: out std_logic);
		 
		 
end fulladder;

architecture structural of fulladder is

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
	
	signal s_NA			: std_logic;
	signal s_NB			: std_logic;
	signal s_NCin		: std_logic;
	signal s_t0			: std_logic;
	signal s_t1			: std_logic;
	signal s_t2			: std_logic;
	signal s_t3			: std_logic;
	signal s_t4			: std_logic;
	signal s_t6			: std_logic;
	signal s_u0			: std_logic;
	signal s_u1			: std_logic;
	signal s_u2			: std_logic;
	signal s_v0			: std_logic;
	signal s_v1			: std_logic;	
	
begin

	NGATEA: 	invg 
		port map(i_A 		=> i_A,
				 o_F		=> s_NA);
				 
	NGATEB:		invg 
		port map(i_A 		=> i_B,
				 o_F		=> s_NB);
				 
	NGATECin: 	invg 
		port map(i_A 		=> i_Cin,
				 o_F		=> s_NCin);
				 
	ANDGATE0: andg2
		port map(i_A		=> s_NB,
				 i_B		=> i_Cin,
				 o_F		=> s_t0);
				 
	ANDGATE1: andg2
		port map(i_A		=> i_B,
				 i_B		=> s_NCin,
				 o_F		=> s_t1);
				 
	ANDGATE2: andg2
		port map(i_A		=> i_B,
				 i_B		=> i_Cin,
				 o_F		=> s_t2);
				 
	ANDGATE3: andg2
		port map(i_A		=> s_NB,
				 i_B		=> s_NCin,
				 o_F		=> s_t3);				 

	ANDGATE4: andg2
		port map(i_A		=> s_t4,
				 i_B		=> i_A,
				 o_F		=> s_u2);

	ANDGATE5: andg2
		port map(i_A		=> s_u0,
				 i_B		=> s_NA,
				 o_F		=> s_v0);
				 
	ANDGATE6: andg2
		port map(i_A		=> i_A,
				 i_B		=> s_u1,
				 o_F		=> s_v1);
				 
	ORGATE0: org2
		port map(i_A		=> i_B,
				 i_B		=> i_Cin,
				 o_F		=> s_t4);
				 
	ORGATE1: org2
		port map(i_A		=> s_t0,
				 i_B		=> s_t1,
				 o_F		=> s_u0);
				 
	ORGATE2: org2
		port map(i_A		=> s_t2,
				 i_B		=> s_t3,
				 o_F		=> s_u1);				 
				 
	ORGATE3: org2
		port map(i_A		=> s_t2,
				 i_B		=> s_u2,
				 o_F		=> o_C);				 
				 
	ORGATE4: org2
		port map(i_A		=> s_v0,
				 i_B		=> s_v1,
				 o_F		=> o_S);				 
end structural;

