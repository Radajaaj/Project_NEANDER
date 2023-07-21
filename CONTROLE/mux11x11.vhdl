library IEEE;
use IEEE.std_logic_1164.all;

entity mux11x11 is port
(
    A : in std_logic_vector (7 downto 0); --NOP
    B : in std_logic_vector (7 downto 0);--STA
    C : in std_logic_vector (7 downto 0);--LDA
    D : in std_logic_vector (7 downto 0);--ADD
    E : in std_logic_vector (7 downto 0);--AND
    F : in std_logic_vector (7 downto 0); --OR
    G : in std_logic_vector (7 downto 0);--NOT
    H : in std_logic_vector (7 downto 0);--JMP
    I : in std_logic_vector (7 downto 0);--JN
    J : in std_logic_vector (7 downto 0);--JZ
    K : in std_logic_vector (7 downto 0);--HLT
    sel : in std_logic_vector (2 downto 0);--DEC2UC
    H : out std_logic_vector(7 downto 0)--Barramento Controle
);
end mux11x11;

architecture hard of mux5x8 is 
begin
    
   H <= A when sel ="100" else
        B when sel ="011" else
        C when sel ="010"else
        D when sel ="001"else
        E when sel ="000";

end hard;