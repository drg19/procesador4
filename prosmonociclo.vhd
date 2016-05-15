library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;


entity procesador_monociclo is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador_monociclo;

architecture Behavioral of procesador_monociclo is

	component IM 
    Port ( reset : in  STD_LOGIC;
           adres : in  STD_LOGIC_VECTOR (31 downto 0);
           IMout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ALU 
    Port ( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0);
			  carry : in  STD_LOGIC;
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component SEU 
    Port ( simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component SEU_22 
    Port ( disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component ControlUnit 
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  Op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  icc: in STD_LOGIC_VECTOR (3 downto 0);
			  cond: in STD_LOGIC_VECTOR (3 downto 0);
			  rfDest : out  STD_LOGIC;
			  rfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  wrEnMem : out  STD_LOGIC;
           wrEnRF : out  STD_LOGIC;	
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           AluOp : out  STD_LOGIC_VECTOR (5 downto 0));
			  
	end component;
	
	component muxRFDest 
    Port ( nrd : in  STD_LOGIC_VECTOR (5 downto 0);
           registroO7 : in  STD_LOGIC_VECTOR (5 downto 0);
           RFDestSel : in  STD_LOGIC;
           RFDest : out  STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	component muxALU 
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component muxPCSource 
    Port ( PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));		
	end component;
	
	component mux_4 
    Port ( DatatoMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           Aluop : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           Muxout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component DataMemory 
    Port ( rst : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           writEnable : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (31 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component PC 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           address  : in  STD_LOGIC_VECTOR(31 downto 0) ;
           next_instruction : out  STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
  COMPONENT registerFile
    PORT(
         reset : IN  std_logic;
         rS1 : IN  std_logic_vector(4 downto 0);
         rS2 : IN  std_logic_vector(4 downto 0);
         rD : IN  std_logic_vector(4 downto 0);
         dataToWrite : IN  std_logic_vector(31 downto 0);
			WriteEnable : IN std_logic;
         cRS1 : OUT  std_logic_vector(31 downto 0);
         cRS2 : OUT  std_logic_vector(31 downto 0);
			cRD : OUT std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	
	component Sumador 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Cout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component UC 
    Port ( op : in  STD_LOGIC_VECTOR(1 downto 0);
           op3  : in  STD_LOGIC_VECTOR(5 downto 0);
           Aluop : out  STD_LOGIC_VECTOR(5 downto 0));
	end component;
	
	component nPC 
    Port ( addres : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sgteinstruccion : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	
	component PSRM is
    Port ( reset : in STD_LOGIC;
			  Op1 : in  STD_LOGIC;
           Op2 : in  STD_LOGIC;
			  Aluresult : in  STD_LOGIC_VECTOR (31 downto 0);
           Aluop : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
		end component;
	
	COMPONENT PSR
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		nCWP : IN std_logic_vector(1 downto 0);          
		CWP : OUT std_logic_vector(1 downto 0);
		carry : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	component WindowsManager 
    Port ( Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 1
           Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 2
           Rd : in  STD_LOGIC_VECTOR (4 downto 0);--Register Destination
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (1 downto 0);--Current Window Pointer
			  --RO7 : in STD_LOGIC_VECTOR (5 downto 0);
           nCWP : out  STD_LOGIC_VECTOR (1 downto 0);--New Current Windows Pointer
           nRs1 : out  STD_LOGIC_VECTOR (5 downto 0);--New Register Source 1
           nRs2 : out  STD_LOGIC_VECTOR (5 downto 0);--New Register Source 2
           nRd : out  STD_LOGIC_VECTOR (5 downto 0));--New Register Destination

	end component;

signal A,B,C,D,E,F,G,I,J,L,M,N,O,K,H,Q,R,S,T,U,Z,A1,A8: STD_LOGIC_VECTOR (31 downto 0);
signal CA,W,Y,A9,A6,A7: STD_LOGIC;
signal X,A2,A3,P : STD_LOGIC_VECTOR(1 downto 0);
signal A4,A5 : STD_LOGIC_VECTOR(3 downto 0);
signal V: STD_LOGIC_VECTOR(5 downto 0);


 
begin

Inst_nPC: nPC PORT MAP(
		addres => F,
		clk => clk,
		reset => reset ,
		sgteinstruccion => C 
	);

------------------------------------		
	Inst_PC: PC PORT MAP(
		clk => clk,
		reset => reset,
		address => C,
		next_instruction => E
	);
				
-----------------------------------
	Inst_Sumador: Sumador PORT MAP(
		A => "00000000000000000000000000000001",
		B => C,
		Cout => D
	);

---------------------------------
	Inst_IM: IM PORT MAP(
		reset => reset,
		adres => E,
		IMout => G
	);
---------------------------------

	Inst_ControlUnit: ControlUnit PORT MAP(
		Op => G(31 downto 30),
		Op2 =>G(24 downto 22 ),
		Op3 =>G(24 downto 19),
		icc =>A5(3 downto 0),
		cond => G(28 downto 25),
		rfDest => W,
		rfSource =>X (1 downto 0),
		wrEnMem => Y,
		wrEnRF => A9,
		pcSource => P,
		AluOp =>V 
	);

--------------------------------

		Inst_registerFile: registerFile PORT MAP(
		reset => reset,
		rS1 => Z(18 downto 14),
		rS2 => Z(4 downto 0),
		rD => A8 (4 downto 0),
		WriteEnable => A7,
		dataToWrite =>H ,
		cRS1 => K,
		cRS2 => J,
		cRD => O
	);
----------------------------------------------
	Inst_SEU: SEU PORT MAP(
		simm13 => G(12 downto 0),
		simm32 => I
	);

------------------------------------------------
--	 multiplexor: mux 
--    Port map 
--				( 	
				--	UESout => I,
					--CRS2 => J,
					--inmediato => G(13),
					--muxout =>L
				 --);


------------------------------------------------
	Inst_ALU: ALU PORT MAP(
		CRS1 => K,
		CRS2 => L,
		ALURESULT =>M ,
		carry => A6,
		ALUOP => V (5 downto 0) 
	);
				
----------------------------------------------
	Inst_PSRM: PSRM PORT MAP(
		reset => reset,
		Op1 => K(31),
		Op2 => L(31),
		Aluresult =>M ,
		Aluop => V(5 downto 0),
		nzvc => A4 ( 3 downto 0)
	);
-------------------------------
	Inst_PSR: PSR PORT MAP(
		clk => clk,
		reset => reset,
		nzvc => A4 (3 downto 0),
		nCWP => A3,
		CWP => A2,
		carry => A6,
		icc => A5
	);

---------------------------------
	Inst_SEU_22: SEU_22 PORT MAP(
		disp22 => G (21 downto 0),
		simm32 => Q
	);

---------------------------------
	Inst_WindowsManager: WindowsManager PORT MAP(
		Rs1 => G (18 downto 14),
		Rs2 => G (4 downto 0),
		Rd => G(29 downto 25),
		OP => G(31 downto 30),
		OP3 => G(24 downto 19),
		CWP => A2,
		nCWP => A3,
		nRs1 => Z (5 downto 0),
		nRs2 => Z( 10 downto 5),
		nRd => A1 (5 downto 0)
	);
---------------------------------

	Inst_muxALU: muxALU PORT MAP(
		Crs2 => J,
		SEUOperando => I ,
		selImmediate => G(13),
		OperandoALU => L
	);


--------------------------------
Inst_muxPCSource: muxPCSource PORT MAP(
		PCDisp30 => U,
		PCDisp22 => T,
		PC4 => D,
		PCAddress => M,
		PCSource => P,
		PCAddressOut => F 
	);
-------------------------------
Inst_muxRFDest: muxRFDest PORT MAP(
		nrd => A1(5 downto 0) ,
		registroO7 => "001111",
		RFDestSel =>W ,
		RFDest => A8 (5 downto 0)
	);

-------------------------------
	Inst_mux_4: mux_4 PORT MAP(
		DatatoMemory => N,
		Aluop => M,
		PC => E,
		RFSource => X ,
		Muxout => H
	);
-------------------------------
Inst_Sumador1: Sumador PORT MAP(
		A => E,
		B => Q,
		Cout => T 
	);
-------------------------------
Inst_Sumador2: Sumador PORT MAP(
		A => G,
		B => E,
		Cout => U 
	);
-------------------------------

	Inst_DataMemory: DataMemory PORT MAP(
		rst => reset ,
		data => O,
		writEnable =>Y ,
		address => M,
		dataOut => N
	);
------------------------------
----ALURESULT <= L;





end Behavioral;


