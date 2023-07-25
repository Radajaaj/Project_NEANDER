library IEEE;
use IEEE.std_logic_1164.all;
 
entity mux2x8 is port
(
    Bar : in std_logic_vector(7 downto 0 ) ;
    PC : in std_logic_vector(7 downto 0 ) ;
    sel : in std_logic;
    S : out std_logic_vector(7 downto 0 )
);
end entity;

architecture hard  of mux2x8 is 
begin
    
   S <= Bar when sel = '0' else PC;
    
    
end hard ;