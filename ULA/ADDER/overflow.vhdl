library ieee;
use ieee.std_logic_1164.all;

 
entity overflow is
    port(
        Aov : in std_logic;
        Bov : in std_logic;
        Sov : in std_logic;
        Ov : out std_logic
        ); 
end entity;

architecture overflacao of overflow is
    begin

    Ov <= ((not Aov) and (not Bov) and Sov) or (Aov and Bov and (not Sov));
end architecture; 