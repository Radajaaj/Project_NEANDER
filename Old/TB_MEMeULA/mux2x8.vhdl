library IEEE;
use IEEE.std_logic_1164.all;
 
entity mux2x8 is port
(
    A : in std_logic_vector(7 downto 0 ) ;
    B : in std_logic_vector(7 downto 0 ) ;
    sel : in std_logic;
    S : out std_logic_vector(7 downto 0 )
);
end entity;

architecture hard  of mux2x8 is 
begin
    
   S <= A when sel = '0' else B;
    
    
end hard ;