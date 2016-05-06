library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 

 
ENTITY WindowsManager_Tb IS
END WindowsManager_Tb;
 
ARCHITECTURE behavior OF WindowsManager_Tb IS 
 
 
    COMPONENT WindowsManager
    PORT(
         Rs1 : IN  std_logic_vector(4 downto 0);
         Rs2 : IN  std_logic_vector(4 downto 0);
         Rd : IN  std_logic_vector(4 downto 0);
         OP : IN  std_logic_vector(1 downto 0);
         OP3 : IN  std_logic_vector(5 downto 0);
         CWP : IN  std_logic;
         nCWP : OUT  std_logic;
         nRs1 : OUT  std_logic_vector(5 downto 0);
         nRs2 : OUT  std_logic_vector(5 downto 0);
         nRd : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Rd : std_logic_vector(4 downto 0) := (others => '0');
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal OP3 : std_logic_vector(5 downto 0) := (others => '0');
   signal CWP : std_logic := '0';

 	--Outputs
   signal nCWP : std_logic;
   signal nRs1 : std_logic_vector(5 downto 0);
   signal nRs2 : std_logic_vector(5 downto 0);
   signal nRd : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WindowsManager PORT MAP (
          Rs1 => Rs1,
          Rs2 => Rs2,
          Rd => Rd,
          OP => OP,
          OP3 => OP3,
          CWP => CWP,
          nCWP => nCWP,
          nRs1 => nRs1,
          nRs2 => nRs2,
          nRd => nRd
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
         Rs1 <= "10000";
         Rs2 <= "10001";
         Rd <= "10010";
         OP <= "10";
         OP3 <= "111100";
         CWP <= '1';
      wait for 100 ns;	
         OP3 <= "000000";
         CWP <= '0';
      wait for 100 ns;	

   end process;

END;
