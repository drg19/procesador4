library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sumador is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Cout : out  STD_LOGIC_VECTOR (31 downto 0));
end Sumador;

architecture Behavioral of Sumador is

begin

 Cout <= A+B;  


end Behavioral; 
