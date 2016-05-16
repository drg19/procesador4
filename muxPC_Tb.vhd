--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:04:31 05/16/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Downloads/procesador6-copia/procesador6 - copia/muxPC_Tb.vhd
-- Project Name:  procesador6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: muxPCSource
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
 
ENTITY muxPC_Tb IS
END muxPC_Tb;
 
ARCHITECTURE behavior OF muxPC_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT muxPCSource
    PORT(
         PCDisp30 : IN  std_logic_vector(31 downto 0);
         PCDisp22 : IN  std_logic_vector(31 downto 0);
         PC4 : IN  std_logic_vector(31 downto 0);
         PCAddress : IN  std_logic_vector(31 downto 0);
         PCSource : IN  std_logic_vector(1 downto 0);
         PCAddressOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PCDisp30 : std_logic_vector(31 downto 0) := (others => '0');
   signal PCDisp22 : std_logic_vector(31 downto 0) := (others => '0');
   signal PC4 : std_logic_vector(31 downto 0) := (others => '0');
   signal PCAddress : std_logic_vector(31 downto 0) := (others => '0');
   signal PCSource : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal PCAddressOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: muxPCSource PORT MAP (
          PCDisp30 => PCDisp30,
          PCDisp22 => PCDisp22,
          PC4 => PC4,
          PCAddress => PCAddress,
          PCSource => PCSource,
          PCAddressOut => PCAddressOut
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
		PCDisp30 <= x"00001001";
      PCDisp22 <= x"00000101";
      PC4 <= x"00000011";
      PCAddress <= x"00000001";
      PCSource <= "10";
      -- hold reset state for 100 ns.
      wait for 100 ns;	



      -- insert stimulus here 

      wait;
   end process;

END;
