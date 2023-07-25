library ieee;
use ieee.std_logic_1164.all;
 
entity somador8bit is
    port(
        Asum   : in  std_logic_vector (7 downto 0);
        Bsum   : in  std_logic_vector (7 downto 0);
        Cin    : in  std_logic;
        Sumado : out std_logic_vector (7 downto 0);
        Cout   : out std_logic
    );
end entity;
 
architecture somagem of somador8bit is
    component somado is
        port(
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            s    : out std_logic;
            cout : out std_logic
            );
    end component; 

    signal carry : std_logic_vector (7 downto 0);

    begin

        u_soma0 : somado port map (
            Asum(0), Bsum(0), Cin, Sumado(0), carry(0)
        );

        u_soma1 : somado port map (
            Asum(1), Bsum(1), carry(0), Sumado(1), carry(1)
        );

        u_soma2 : somado port map (
            Asum(2), Bsum(2), carry(1), Sumado(2), carry(2)
        );

        u_soma3 : somado port map (
            Asum(3), Bsum(3), carry(2), Sumado(3), carry(3)
        );

        u_soma4 : somado port map (
            Asum(4), Bsum(4), carry(3), Sumado(4), carry(4)
        );

        u_soma5 : somado port map (
            Asum(5), Bsum(5), carry(4), Sumado(5), carry(5)
        );

        u_soma6 : somado port map (
            Asum(6), Bsum(6), carry(5), Sumado(6), carry(6)
        );

        u_soma7 : somado port map (
            Asum(7), Bsum(7), carry(6), Sumado(7), carry(7)
        );
    end architecture;

