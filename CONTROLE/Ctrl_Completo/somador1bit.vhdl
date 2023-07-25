library ieee;
use ieee.std_logic_1164.all;
  
entity somado1 is
    port(
        a    : in std_logic;
        b    : in std_logic;
        cin  : in std_logic;
        s    : out std_logic;
        cout : out std_logic
        );
end entity;

 
architecture somindo of somado1 is
    begin
        cout <= (a and (b or cin)) or (b and cin);
        s <= (a xor b) xor cin;
end architecture;