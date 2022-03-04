-------------------------------------------------------------------------
-- Dawood Ghauri (DG)
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- onescomp_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide one's complementor
-- using structural VHDL, generics, and generate statements.
--
-- NOTES:
-- 2/20/2021 by DG: Initial Creation.
-- 2/23/2021 by DG: Changed o_O to o_invOut to prevent variable name conflicts.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onescomp_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_D          : in std_logic_vector(N-1 downto 0);
       o_invOut     : out std_logic_vector(N-1 downto 0));

end onescomp_N;

architecture structural of onescomp_N is

  component invg is
	port(i_A          : in std_logic;
		 o_F          : out std_logic);

  end component;

begin

  -- Instantiate N mux instances.
  G_NBit_OnesComp: for i in 0 to N-1 generate
    OC1: invg port map(
              i_A      => i_D(i),  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_F      => o_invOut(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_OnesComp;
  
end structural;
