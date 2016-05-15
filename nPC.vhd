library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nPC is
    Port ( addres : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sgteinstruccion : out  STD_LOGIC_VECTOR (31 downto 0));
end nPC;

architecture Behavioral of nPC is

begin

	process(addres,clk, reset)
		begin
			
			if(reset='0')then
				sgteinstruccion <= (others => '0');
			else
				if(rising_edge(clk))then
					sgteinstruccion <= addres;
				end if;
			end if;		 
		
	end process;

end Behavioral;