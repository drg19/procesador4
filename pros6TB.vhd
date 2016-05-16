LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY pros6TB IS
END pros6TB;
 
ARCHITECTURE behavior OF pros6TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pros6
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         ALURESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ALURESULT : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pros6 PORT MAP (
          clk => clk,
          reset => reset,
          ALURESULT => ALURESULT
        );

   -- Stimulus process
   stim_proc: process
   begin		
     
		reset <='0';
		clk <= '0';
      wait for 100 ns;	
		reset <= '1';
		clk <= '1';
      wait;
   end process;

END;
