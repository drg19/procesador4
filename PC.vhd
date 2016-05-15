library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           address  : in  STD_LOGIC_VECTOR(31 downto 0) ;
           next_instruction : out  STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is

begin
process(clk, reset, address)
	begin
		if (reset = '0') then
			next_instruction <= (others => '0');
		else
			if(rising_edge(clk))then
				next_instruction <= address;
			end if;
		end if;
end process;		
			

end Behavioral;

