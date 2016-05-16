library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU is
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in  STD_LOGIC;
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	PROCESS(CRS1,CRS2, ALUOP,carry)
	
		begin
		
			case(ALUOP) is
				when "000000" => -- add 
					ALURESULT <= CRS1 + CRS2;
					
				when "000101" => -- andn
					ALURESULT <= CRS1 NAND CRS2;
					
				when "000010" =>  --or
					ALURESULT <= CRS1 OR CRS2;
					
				when "000011" => --xor
					ALURESULT <= CRS1 XOR CRS2;
				
				when "000111" => --xnor
					ALURESULT <= CRS1 XOR not(CRS2);
					
				when "000110" => --nor
					ALURESULT <= CRS1 NOR CRS2;
					
				when "000100" => --sub
					ALURESULT <= CRS1 - CRS2;
					
				when "000001" => --and
					ALURESULT <= CRS1 AND CRS2;
				
				when "010001" => --andcc
					ALURESULT <= CRS1 AND CRS2;
					
				when "010101" => --andNcc
					ALURESULT <= CRS1 NAND CRS2;
					
				when "010010" => --ORcc
					ALURESULT <= CRS1 OR CRS2;
					
				when "010110" => --ORNcc
					ALURESULT <= CRS1 NOR CRS2;--
					
				when "010011" => --XORcc
					ALURESULT <= CRS1 XOR CRS2;--
			
				when "010111" => --XORNcc
					ALURESULT <= CRS1 XNOR CRS2;--
					
				when "010000" => --ADDCC
					ALURESULT <= CRS1 + CRS2;--
					
				when "011000" => --ADDXCC
					ALURESULT <= CRS1 + CRS2 + carry;--
					
				when "001000" => --ADDX
					ALURESULT <= CRS1 + CRS2 + carry;--
					
				when "010100" => --SUBCC
					ALURESULT <= CRS1 - CRS2;--
					
				when "001100" => --SUBX
					ALURESULT <= CRS1 - CRS2 - carry;--
					
				when "011100" => --SUBXCC
					ALURESULT <= CRS1 - CRS2 - carry;--
					
				when others => -- Cae el nop
					AluResult <= (others=>'0');	
					
			 end case;		
		
	end process;

end Behavioral;

