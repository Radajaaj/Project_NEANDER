library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is port
(
    A : in std_logic ;
    B : in std_logic ;
    sel : in std_logic;
    H : out std_logic
);
end entity;

architecture hard  of mux2x1 is 
begin
    
    H <= A when sel = '0' else B;
    
    
end hard ;