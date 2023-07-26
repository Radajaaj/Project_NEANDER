library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
    
entity ctrl is
    port(
    q : in  std_logic_vector(2 downto 0);
    j : out std_logic_vector(2 downto 0);
    k : out std_logic_vector(2 downto 0)
    );
end entity;

architecture control of ctrl is
begin
    j(0) <= '1';
    k(0) <= '1';
    j(1) <= q(0);
    k(1) <= q(0);
    j(2) <= q(1) and q(0);
    k(2) <= q(0) and q(1);
end architecture;
