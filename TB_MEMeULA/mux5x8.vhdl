library IEEE;
use IEEE.std_logic_1164.all;

entity mux5x8 is port
(
    A : in std_logic_vector (7 downto 0); --NOT
    B : in std_logic_vector (7 downto 0);--AND
    C : in std_logic_vector (7 downto 0);--OR
    D : in std_logic_vector (7 downto 0);--ADD
    E : in std_logic_vector (7 downto 0);--LDA
    sel : in std_logic_vector (2 downto 0);--ULA_op
    H : out std_logic_vector(7 downto 0)--s_resultado
);
end mux5x8;

architecture hard of mux5x8 is 
begin
    
   H <= A when sel ="100" else
        B when sel ="011" else
        C when sel ="010"else
        D when sel ="001"else
        E when sel ="000";

end hard;