--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:11:06 05/16/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Downloads/procesador6-copia/procesador6 - copia/Mux_DW_Tb.vhd
-- Project Name:  procesador6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux_DataToWr
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
 
ENTITY Mux_DW_Tb IS
END Mux_DW_Tb;
 
ARCHITECTURE behavior OF Mux_DW_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux_DataToWr
    PORT(
         DataToMem : IN  std_logic_vector(31 downto 0);
         AluResult : IN  std_logic_vector(31 downto 0);
         Pc : IN  std_logic_vector(31 downto 0);
         RfSource : IN  std_logic_vector(1 downto 0);
         DataToReg : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataToMem : std_logic_vector(31 downto 0) := (others => '0');
   signal AluResult : std_logic_vector(31 downto 0) := (others => '0');
   signal Pc : std_logic_vector(31 downto 0) := (others => '0');
   signal RfSource : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal DataToReg : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux_DataToWr PORT MAP (
          DataToMem => DataToMem,
          AluResult => AluResult,
          Pc => Pc,
          RfSource => RfSource,
          DataToReg => DataToReg
        );

   -- Clock process definitions
   -- Stimulus process
   stim_proc: process
   begin		
			 DataToMem <= x"00000001";
          AluResult <= x"00000101";
          Pc <= x"00000011";
          RfSource <= "01";
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
