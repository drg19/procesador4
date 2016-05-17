library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WindowsManager is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
			  rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : in  STD_LOGIC;
			  
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC:='0';
			  
			  Registro07 : out STD_LOGIC_VECTOR (5 downto 0));
end WindowsManager;

architecture Behavioral of WindowsManager is

signal rs1I,rs2I,rdI: integer range 0 to 39:=0;
--signal auxRegistroO7 : std_logic_vector(6 downto 0);
--signal mul:std_logic_vector(1 downto 0);

begin
	process(cwp)
		begin
			if (cwp = '1') then
				Registro07 <= "011111";
			else
				Registro07 <= "001111";
			end if;		
	end process;
	
	process(op, op3, rd, rs1, rs2, cwp)
		begin
		
		if(op = "10" and op3 = "111100")then--SAVE
			ncwp <= '0';
		else
			if(op = "10" and op3 = "111101")then--RESTORE
				ncwp <= '1';
			end if;
		end if;
		
		if(rs1>="00000" and rs1<="00111") then -- 0 - 7
			rs1I <= conv_integer(rs1);
		else
			if(rs1>="11000" and rs1<="11111") then--24 - 31
				rs1I <= conv_integer(rs1)-(conv_integer(cwp)*16);
			else
				if(rs1>="10000" and rs1<="10111") then--16-23
					rs1I <= conv_integer(rs1)+(conv_integer(cwp)*16);
				else
						if(rs1>="01000" and rs1<="01111") then--8 - 15
							rs1I <= conv_integer(rs1)+ (conv_integer(cwp)*16);
						end if;
				end if;
			end if;
		end if;
		
		if(rs2>="00000" and rs2<="00111") then -- 0 - 7
			rs2I <= conv_integer(rs2);
		else
			if(rs2>="11000" and rs2<="11111") then--24 - 31
				rs2I <= conv_integer(rs2)-(conv_integer(cwp)*16);
			else
				if(rs2>="10000" and rs2<="10111") then--16-23
					rs2I <= conv_integer(rs2)+(conv_integer(cwp)*16);
				else
						if(rs2>="01000" and rs2<="01111") then--8 - 15
							rs2I <= conv_integer(rs2)+ (conv_integer(cwp)*16);
						end if;
				end if;
			end if;
		end if;
		
		
		if(rd>="00000" and rd<="00111") then -- 0 - 7
			rdI <= conv_integer(rd);
		else
			if(rd>="11000" and rd<="11111") then--24 - 31
				rdI <= conv_integer(rd)-(conv_integer(cwp)*16);
			else
				if(rd>="10000" and rd<="10111") then--16-23
					rdI <= conv_integer(rd)+(conv_integer(cwp)*16);
				else
						if(rd>="01000" and rd<="01111") then--8 - 15
							rdI <= conv_integer(rd)+ (conv_integer(cwp)*16);
						end if;
				end if;
			end if;
		end if;	
	
	end process;
	
	nrs1 <= conv_std_logic_vector(rs1I, 6);
	nrs2 <= conv_std_logic_vector(rs2I, 6);
	nrd <= conv_std_logic_vector(rdI, 6);
end Behavioral;
