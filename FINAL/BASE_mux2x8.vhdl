library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x8 is port
(
    A : in std_logic_vector (7 downto 0);
    B : in std_logic_vector (7 downto 0);
    sel : in std_logic;
    S : out std_logic_vector (7 downto 0)
);
end entity;

architecture hard8  of mux2x8 is 
begin
     
    S <= A when sel = '0' else B;
    
end architecture;