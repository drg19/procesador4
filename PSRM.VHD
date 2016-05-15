library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRM is
    Port ( reset : in STD_LOGIC;
			  Op1 : in  STD_LOGIC;
           Op2 : in  STD_LOGIC;
			  Aluresult : in  STD_LOGIC_VECTOR (31 downto 0);
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSRM;

architecture Behavioral of PSRM is

begin

	process(Aluop,Op1,Op2,Aluresult,reset)
	begin
	
	if (reset = '0')then
		nzvc <= (others => '0');
		
	else		
		if(Aluop = "010000" or Aluop = "011000")then --Addcc - Addxcc	
			nzvc(3) <= Aluresult(31);	
			if(Aluresult = X"00000000")then
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;		
			nzvc(1) <= (Op1 and Op2 and (not Aluresult(31))) or ((not Op1) and (not Op2) and Aluresult(31));
			nzvc(0) <= (Op1 and Op2) or ((not Aluresult(31)) and (Op1 or Op2));
			
		else
			if(Aluop = "010100" or Aluop = "011100")then --Subcc - Subxcc
				nzvc(3) <= Aluresult(31);	
				if(Aluresult = X"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= ((Op1 and (not Op2) and (not Aluresult(31))) or ((not Op1) and Op2 and Aluresult(31)));
				nzvc(0) <= ((not Op1) and Op2) or (Aluresult(31) and ((not Op1) or Op2));
				
			else
				if(Aluop = "001111" or Aluop = "010000" or Aluop = "010001" or Aluop = "010010" or Aluop = "010011" or Aluop = "010100")then
					nzvc(3) <= Aluresult(31);	
					if(Aluresult = X"00000000")then
						nzvc(2) <= '1';
					else
						nzvc(2) <= '0';
					end if;
					nzvc(1) <= '0';
					nzvc(0) <= '0';
				--else
					--nzvc <= "1000";
				end if;
			end if;
		end if;
	end if;
	end process;

end Behavioral;