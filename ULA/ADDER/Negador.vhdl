library ieee;
use ieee.std_logic_1164.all;
 
entity negador is
    port(
        Bnegara : in  std_logic_vector (11 downto 0);
        Bnegado : out std_logic_vector (11 downto 0)
);
end entity;

architecture negacao of negador is
begin
    Bnegado <= not Bnegara;

end architecture;