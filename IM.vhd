library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity IM is
    Port ( reset : in  STD_LOGIC;
           adres : in  STD_LOGIC_VECTOR (31 downto 0);
           IMout : out  STD_LOGIC_VECTOR (31 downto 0));
end IM;

architecture Behavioral of IM is

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
	impure function InitRomFromFile (RomFileName : in string) return rom_type is
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
			begin
				for I in rom_type'range loop
						readline (RomFile, RomFileLine);
						read(RomFileLine, temp_bv);
						temp_mem(i) := to_stdlogicvector(temp_bv);
					end loop;
				return temp_mem;
	end function;
	
	signal instructions : rom_type := InitRomFromFile("memoria.txt");

--//////////////////////////////////////////////////
--/////////////////////////////////////////////////////
begin

	process(reset,adres,instructions)--clk)
	begin
			if(reset = '0')then
				 IMout <= (others=>'0');
			else
				 IMout <= instructions(conv_integer(adres(5 downto 0)));
			end if;
	end process;


end Behavioral;

