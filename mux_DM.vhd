library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_4 is
    Port ( DatatoMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           Aluop : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           Muxout : out  STD_LOGIC_VECTOR (31 downto 0));
end mux_4;

architecture Behavioral of mux_4 is
begin 
process(DatatoMemory,Aluop,PC,RFSource)
begin
	
	case RFSource is
			when "11" => ----- load
				Muxout <= DatatoMemory;
			when "01" =>
				Muxout <= PC;
			when others =>
				Muxout <= Aluop;
		end case;
end process;

end Behavioral;

