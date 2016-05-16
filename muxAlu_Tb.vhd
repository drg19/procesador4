--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:28:40 05/16/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Downloads/procesador6-copia/procesador6 - copia/muxAlu_Tb.vhd
-- Project Name:  procesador6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: muxALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY muxAlu_Tb IS
END muxAlu_Tb;
 
ARCHITECTURE behavior OF muxAlu_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxALU
    PORT(
         Crs2 : IN  std_logic_vector(31 downto 0);
         SEUOperando : IN  std_logic_vector(31 downto 0);
         selImmediate : IN  std_logic;
         OperandoALU : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal SEUOperando : std_logic_vector(31 downto 0) := (others => '0');
   signal selImmediate : std_logic := '0';

 	--Outputs
   signal OperandoALU : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxALU PORT MAP (
          Crs2 => Crs2,
          SEUOperando => SEUOperando,
          selImmediate => selImmediate,
          OperandoALU => OperandoALU
        );

   -- Stimulus process
   stim_proc: process
   begin		
		Crs2 <= x"00000101";
		SEUOperando <= x"00000011";
		selImmediate <= '1';
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
