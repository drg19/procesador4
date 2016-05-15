--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:17:57 05/13/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Desktop/Procesadores/pros3/Mux_4_Tb.vhd
-- Project Name:  pros3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux_4
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
 
ENTITY Mux_4_Tb IS
END Mux_4_Tb;
 
ARCHITECTURE behavior OF Mux_4_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_4
    PORT(
         DatatoMemory : IN  std_logic_vector(31 downto 0);
         Aluop : IN  std_logic_vector(31 downto 0);
         PC : IN  std_logic_vector(31 downto 0);
         RFSource : IN  std_logic_vector(1 downto 0);
         Muxout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DatatoMemory : std_logic_vector(31 downto 0) := (others => '0');
   signal Aluop : std_logic_vector(31 downto 0) := (others => '0');
   signal PC : std_logic_vector(31 downto 0) := (others => '0');
   signal RFSource : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Muxout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_4 PORT MAP (
          DatatoMemory => DatatoMemory,
          Aluop => Aluop,
          PC => PC,
          RFSource => RFSource,
          Muxout => Muxout
        );


   -- Stimulus process
   stim_proc: process
   begin		
		DatatoMemory <= "00000000000000000000000000010000";
		Aluop <= "00000000000000000000000000010001";
		PC <= "00000000000000000000000000010010";
		RFSource <= "11";
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	
		RFSource <= "10";
      -- insert stimulus here 

      wait;
   end process;

END;
