library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;


entity pros6 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ALURESULT : out  STD_LOGIC_VECTOR (31 downto 0));
end pros6;

architecture Behavioral of pros6 is

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
	
	component mux 
    Port ( UESout : in  STD_LOGIC_VECTOR (31 downto 0);
           CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           inmediato : in  STD_LOGIC;
           muxout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component PC 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           address  : in  STD_LOGIC_VECTOR(31 downto 0) ;
           next_instruction : out  STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
component registerFile 
    Port ( reset : in  STD_LOGIC;
           rS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rD : in  STD_LOGIC_VECTOR (4 downto 0);
			  WriteEnable : in STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           cRS1 : out  STD_LOGIC_VECTOR (31 downto 0);
           cRS2 : out  STD_LOGIC_VECTOR (31 downto 0);
           cRD : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
	
	component Sumador 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0); 
           Cout : out  STD_LOGIC_VECTOR (31 downto 0));
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
	
	component PSR 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC_VECTOR (1 downto 0);
           CWP : out  STD_LOGIC_VECTOR (1 downto 0);
           carry : out  STD_LOGIC;
           icc : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component muxPCSource 
    Port ( PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component muxALU 
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component muxRFDest 
    Port ( nrd : in  STD_LOGIC_VECTOR (4 downto 0);
           registroO7 : in  STD_LOGIC_VECTOR (4 downto 0);
           RFDestSel : in  STD_LOGIC;
           RFDest : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	component Mux_DataToWr 
    Port ( DataToMem : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           Pc : in  STD_LOGIC_VECTOR (31 downto 0);
			  RfSource :in  STD_LOGIC_VECTOR (1 downto 0);
			  DataToReg : out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component DataMemory 
    Port ( rst : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           writEnable : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (31 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component WindowsManager 
    Port ( Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 1
           Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 2
           Rd : in  STD_LOGIC_VECTOR (4 downto 0);--Register Destination
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC_VECTOR (1 downto 0);
			  --RO7 : in STD_LOGIC_VECTOR (5 downto 0);
           nCWP : out   STD_LOGIC_VECTOR (1 downto 0);
           nRs1 : out  STD_LOGIC_VECTOR (4 downto 0);--New Register Source 1
           nRs2 : out  STD_LOGIC_VECTOR (4 downto 0);--New Register Source 2
           nRd : out  STD_LOGIC_VECTOR (4 downto 0));--New Register Destination

	end component;
	
	component SEU_22 
    Port ( disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

signal A,B,C,D,E,F,G,I,J,L,M,N,O,K,H,Q,R,S,T,U,Z,A1,A8: STD_LOGIC_VECTOR (31 downto 0);
signal CA,Y,A9,A6,A7: STD_LOGIC;
signal X,A2,A3,P : STD_LOGIC_VECTOR(1 downto 0);
signal A4,A5 : STD_LOGIC_VECTOR(3 downto 0);
signal V: STD_LOGIC_VECTOR(5 downto 0);
signal W: STD_LOGIC;
 
begin


----------------------------------------------

	 InstrM :IM  
    Port map( 
				reset =>reset,
				adres =>E,
				IMout =>G
				);
				
-----------------------------------------------


	 ALUU: ALU 
    Port map (   CRS1 => K,
					  CRS2 =>L,
					  ALURESULT =>M,
					  carry =>A6,
					  ALUOP =>V
	);
	
-----------------------------------------------
	
	 SEUU  : SEU 
    Port map ( simm13 =>G(12 DOWNTO 0 ),
					simm32 => I
		);
	
-----------------------------------------------
	
	 PCC : PC
    Port map( clk =>clk,
				  reset =>reset,
				  address  => C,
				  next_instruction =>E
				);
	
-----------------------------------------------
	
		RFF : registerFile 
    Port map( reset =>reset,
           rS1 =>Z(4 DOWNTO 0),
           rS2 =>Z(9 DOWNTO 5),
           rD =>A8(4 DOWNTO 0),
			  WriteEnable =>A9,
			  dataToWrite =>H,
           cRS1 =>K,
           cRS2 =>J,
           cRD =>O
		);

-----------------------------------------------
	
	 Sumadoor : Sumador 
    Port map( 	A => "00000000000000000000000000000001",
					B =>C,
					Cout =>D
				);
	
-----------------------------------------------

	 Sumadoor1 : Sumador
    Port map( 	A =>E,
					B =>Q,
					Cout =>T
				);
	
-----------------------------------------------

	 Sumadoor2 : Sumador
    Port map( 	A =>G,
					B =>E,
					Cout =>U
				);
	
-----------------------------------------------
	
	  ContrU : ControlUnit 
    Port map( Op =>G(31 DOWNTO 30),
			  Op2 =>G(24 DOWNTO 22),
           Op3 =>G(24 DOWNTO 19),
			  icc =>A5(3 DOWNTO 0),
			  cond =>G(28 DOWNTO 25),
			  rfDest =>W,
			  rfSource =>X(1 DOWNTO 0),
			  wrEnMem =>Y,
           wrEnRF =>A9,
			  pcSource =>P,
           AluOp =>V
			  
			);
	
-----------------------------------------------
	
	nextPC : nPC  
    Port map( addres =>F,
           clk =>clk,
           reset =>reset,
           sgteinstruccion =>C
		);
	
-----------------------------------------------
	
	
	 PeSRM :PSRM 
    Port map( reset =>reset,
				  Op1 =>K(31),
				  Op2 =>L(31),
				  Aluresult =>M,
				  Aluop =>V(5 DOWNTO 0),
				  nzvc =>A4(3 DOWNTO 0)
		);
		
-----------------------------------------------
	
	 PeSR : PSR 
    Port map( clk =>clk,
				  reset => reset,
				  nzvc =>A4(3 DOWNTO 0),
				  nCWP =>A3,
				  CWP =>A2,
				  carry =>A6,
				  icc =>A5
				);
	
-----------------------------------------------
	
	muxPCS: muxPCSource 
    Port map( PCDisp30 =>U,
				  PCDisp22 =>T,
				  PC4 =>D,
				  PCAddress =>M,
				  PCSource =>P,
				  PCAddressOut =>F
				);
	
-----------------------------------------------
	
	 muALUU : muxALU 
    Port map( Crs2 =>J,
				  SEUOperando =>I,
				  selImmediate =>G(13),
				  OperandoALU =>L
				);
	
-----------------------------------------------
	
	  muxRFD : muxRFDest  
    Port map( nrd =>A1(4 DOWNTO 0),
				  registroO7 =>"01111",
				  RFDestSel =>W,
				  RFDest =>A8(4 DOWNTO 0)
				);
	
-----------------------------------------------
				
	mux44 : Mux_DataToWr 
    Port map( 
					DataToMem =>N,
					AluResult =>M,
					Pc =>E,
					RfSource =>X,
					DataToReg =>H
				);
	
-----------------------------------------------
	
	 DATMEM : DataMemory 
    Port map( rst =>reset,
           data =>O,
           writEnable =>Y,
           address =>M,
           dataOut =>N
			);
	
-----------------------------------------------
	
	WM : WindowsManager 
    Port map( Rs1 => G (18 downto 14),
					Rs2 => G (4 downto 0),
					Rd => G(29 downto 25),
					OP => G(31 downto 30),
					OP3 => G(24 downto 19),
					CWP => A2,
					nCWP => A3,
					nRs1 => Z (4 downto 0),
					nRs2 => Z(9 downto 5),
					nRd => A1(4 downto 0)

	);
	
-----------------------------------------------
	
	 Seu222 : SEU_22 
    Port map( disp22 =>G(21 downto 0),
					simm32 =>Q
	)			;
	
-----------------------------------------------
ALURESULT <= H;


end Behavioral;


