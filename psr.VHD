library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR;

architecture arqPSR of PSR is


begin
	process(clk)
	begin
		if(rising_edge(clk))then
			if(reset = '0') then
				CWP <= '0';
				carry <= '0';
				icc <= "0000";
			else
				carry <= nzvc(0);
				icc <= nzvc;
				CWP <= nCWP;
			end if;
		end if;
	end process;
end arqPSR;