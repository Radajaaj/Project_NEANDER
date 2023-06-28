library ieee;
use ieee.std_logic_1164.all;
 
entity mux2x12 is
        port(
            Bsim : in  std_logic_vector (11 downto 0);
            Bnao : in  std_logic_vector (11 downto 0);
            Op   : in  std_logic;
            Bout : out std_logic_vector (11 downto 0)
        );
end entity;

architecture muxacao of mux2x12 is
begin

        Bout <= Bsim when Op = '0' else Bnao;

end architecture;