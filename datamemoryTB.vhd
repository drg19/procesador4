LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DataMemomry_tb IS
END DataMemomry_tb;
 
ARCHITECTURE behavior OF DataMemomry_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
    PORT(
         rst : IN  std_logic;
         data : in  STD_LOGIC_VECTOR (31 downto 0);
         writEnable : IN  std_logic;
         address : in  STD_LOGIC_VECTOR (31 downto 0);
         dataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal data :   STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
   signal writEnable : std_logic := '0';
   signal address :   STD_LOGIC_VECTOR (31 downto 0);
 	--Outputs
   signal dataOut : std_logic_vector(31 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory PORT MAP (
          rst => rst,
          data => data,
          writEnable => writEnable,
          address => address,
          dataOut => dataOut
        );

   -- Stimulus process
   stim_proc: process
   begin
		rst <= '1';
		writEnable <= '1';
		address <= "00000000000000000000000000010000";
		data <= "00000000000000000000000000010001";
		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '1';
		writEnable <= '0';
		address <= "00000000000000000000000000010000";
		data <= "00000000000000000000000000010111";

      -- insert stimulus here 

      wait;
   end process;

END;
