--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:51:46 05/16/2016
-- Design Name:   
-- Module Name:   C:/Users/DELL/Downloads/procesador6-copia/procesador6 - copia/PSR_Tb.vhd
-- Project Name:  procesador6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR
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
 
ENTITY PSR_Tb IS
END PSR_Tb;
 
ARCHITECTURE behavior OF PSR_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         nzvc : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic_vector(1 downto 0);
         CWP : OUT  std_logic_vector(1 downto 0);
         carry : OUT  std_logic;
         icc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal CWP : std_logic_vector(1 downto 0);
   signal carry : std_logic;
   signal icc : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          clk => clk,
          reset => reset,
          nzvc => nzvc,
          nCWP => nCWP,
          CWP => CWP,
          carry => carry,
          icc => icc
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
		nzvc <= "0001";
		nCWP <= "10";
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
