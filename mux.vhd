library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux is
    Port ( UESout : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           inmediato : in  STD_LOGIC;
           muxout : out  STD_LOGIC_VECTOR (31 downto 0));
end mux;

architecture Behavioral of mux is

begin

	PROCESS(UESout,CRS2, inmediato)
	
		begin
		
			case(inmediato) is
			
				when '1' =>  
					muxout <= UESout;
					
				when '0' => 
					muxout <= CRS2;
					
				when others =>
					muxout  <= (others=>'0');		
					
			end case;		
		
	end process;


end Behavioral;

