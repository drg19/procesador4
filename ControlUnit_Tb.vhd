--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:11:48 05/16/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Downloads/procesador6-copia/procesador6 - copia/ControlUnit_Tb.vhd
-- Project Name:  procesador6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlUnit
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
 
ENTITY ControlUnit_Tb IS
END ControlUnit_Tb;
 
ARCHITECTURE behavior OF ControlUnit_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         Op : IN  std_logic_vector(1 downto 0);
         Op2 : IN  std_logic_vector(2 downto 0);
         Op3 : IN  std_logic_vector(5 downto 0);
         icc : IN  std_logic_vector(3 downto 0);
         cond : IN  std_logic_vector(3 downto 0);
         rfDest : OUT  std_logic;
         rfSource : OUT  std_logic_vector(1 downto 0);
         wrEnMem : OUT  std_logic;
         wrEnRF : OUT  std_logic;
         pcSource : OUT  std_logic_vector(1 downto 0);
         AluOp : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal Op2 : std_logic_vector(2 downto 0) := (others => '0');
   signal Op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal icc : std_logic_vector(3 downto 0) := (others => '0');
   signal cond : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal rfDest : std_logic;
   signal rfSource : std_logic_vector(1 downto 0);
   signal wrEnMem : std_logic;
   signal wrEnRF : std_logic;
   signal pcSource : std_logic_vector(1 downto 0);
   signal AluOp : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          Op => Op,
          Op2 => Op2,
          Op3 => Op3,
          icc => icc,
          cond => cond,
          rfDest => rfDest,
          rfSource => rfSource,
          wrEnMem => wrEnMem,
          wrEnRF => wrEnRF,
          pcSource => pcSource,
          AluOp => AluOp
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      Op <= "11";
		Op2 <= "010";
		Op3 <= "000100";
		icc <= "1000";
		cond <= "1000";
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
