----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
    Port ( rst : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           writEnable : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (31 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture arqUProcessor of DataMemory is
	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	signal my_Ram : ram_type := (others => x"00000000");
begin
	process(rst,data,writEnable,address)
		begin
			if (rst='0') then
				dataOut <= x"00000000";
			else
				if (writEnable='1') then
					my_Ram(conv_integer(address(4 downto 0))) <= data;
				else
					dataOut <= my_Ram(conv_integer(address(4 downto 0)));
				end if;
			end if;
	end process;

end arqUProcessor;

