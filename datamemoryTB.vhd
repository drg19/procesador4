LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY datamemoryTB IS
END datamemoryTB;
 
ARCHITECTURE behavior OF datamemoryTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dataMemory
    PORT(
         reset : IN  std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         address : IN  std_logic_vector(31 downto 0);
         wrEnMem : IN  std_logic;
         datoMem : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal Data : std_logic_vector(31 downto 0) := (others => '0');
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal wrEnMem : std_logic := '0';

 	--Outputs
   signal datoMem : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dataMemory PORT MAP (
          reset => reset,
          Data => Data,
          address => address,
          wrEnMem => wrEnMem,
          datoMem => datoMem
        );


   -- Stimulus process
   stim_proc: process
   begin		
     
	  
	  reset <='1';
	  Data <= "00000000000000000000000000000100";
	  address <= "00000000000000000000000000001100";
	  wrEnMem <= '1';
     wait for 100 ns;	 

	  wrEnMem <= '1';
		wait for 100 ns;	

      wait;
   end process;

END;
