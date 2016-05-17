library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registerFile is
    Port ( reset : in  STD_LOGIC;
           rS1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rS2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rD : in  STD_LOGIC_VECTOR (5 downto 0);
			  WriteEnable : in STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           cRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           cRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
           cRD : out  STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture arqRegisterFile of registerFile is

	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal registers : ram_type := (others => x"00000000");
begin
--,reset,registerSource1,registerSource2,registerDestination,writeEnable,dataToWrite
	process(reset,rS1,rS2,rD,dataToWrite,WriteEnable)--clkFPGA)
	begin
		--if(rising_edge(clkFPGA))then
			if(reset = '0')then
				cRS1 <= (others=>'0');
				cRS2 <= (others=>'0');
				cRD <= (others => '0');
				registers <= (others => x"00000000");
			else
				cRS1 <= registers(conv_integer(rS1));
				cRS2 <= registers(conv_integer(rS2));
				cRD <= registers(conv_integer(rD));
				if(WriteEnable = '1' and rD /= "00000")then
					registers(conv_integer(rD)) <= dataToWrite;
				end if;
			end if;
		--end if;
	end process;
end arqRegisterFile;
