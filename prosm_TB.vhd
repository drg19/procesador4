
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY prosm_TB IS
END prosm_TB;
 
ARCHITECTURE behavior OF prosm_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pros3
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

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pros3 PORT MAP (
          clk => clk,
          reset => reset,
          ALURESULT => ALURESULT
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
     
	  clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='0';
	  reset <= '1';
      wait for 100 ns;
		
		clk <='1';
	  reset <= '1';
      wait for 100 ns;


      -- insert stimulus here 

      wait;
   end process;

END;
