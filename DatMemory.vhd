library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity dataMemory is
    Port ( 
			  reset : in STD_LOGIC;
			  Data : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in STD_LOGIC_VECTOR (31 downto 0);				
           wrEnMem : in  STD_LOGIC;
           datoMem : out  STD_LOGIC_VECTOR (31 downto 0));
end dataMemory;

architecture arqDataMemory of dataMemory is
	type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
	signal ramMemory : ram_type:=(others => x"00000000");
begin
	--reset,cRD,address,wrEnMem)
	process(reset,Data,address,wrEnMem)
	begin
				if(reset = '0')then
					datoMem <= (others => '0');
					--ramMemory <= (others => x"00000000");
				else
					--datoMem <= ramMemory(conv_integer(address(4 downto 0)));
					if(wrEnMem = '1')then
						datoMem <= ramMemory(conv_integer(address(4 downto 0)));
					else
						ramMemory(conv_integer(address(4 downto 0))) <= Data;
					end if;
				end if;
	end process;
end arqDataMemory;
