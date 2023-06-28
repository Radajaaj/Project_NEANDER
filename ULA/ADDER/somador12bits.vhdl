library ieee;
use ieee.std_logic_1164.all;
 
entity somador12bits is
    port(
        Asum   : in  std_logic_vector (11 downto 0);
        Bsum   : in  std_logic_vector (11 downto 0);
        Cin    : in  std_logic;
        Sumado : out std_logic_vector (11 downto 0);
        Cout   : out std_logic
    );
end entity;
 
architecture somagem of somador12bits is
    component somador is
        port(
            a    : in std_logic;
            b    : in std_logic;
            cin  : in std_logic;
            s    : out std_logic;
            cout : out std_logic
            );
    end component; 

    signal carry : std_logic_vector (10 downto 0);

    begin

        u_soma0 : somador port map (
            Asum(0), Bsum(0), Cin, Sumado(0), carry(0)
        );

        u_soma1 : somador port map (
            Asum(1), Bsum(1), carry(0), Sumado(1), carry(1)
        );

        u_soma2 : somador port map (
            Asum(2), Bsum(2), carry(1), Sumado(2), carry(2)
        );

        u_soma3 : somador port map (
            Asum(3), Bsum(3), carry(2), Sumado(3), carry(3)
        );

        u_soma4 : somador port map (
            Asum(4), Bsum(4), carry(3), Sumado(4), carry(4)
        );

        u_soma5 : somador port map (
            Asum(5), Bsum(5), carry(4), Sumado(5), carry(5)
        );

        u_soma6 : somador port map (
            Asum(6), Bsum(6), carry(5), Sumado(6), carry(6)
        );

        u_soma7 : somador port map (
            Asum(7), Bsum(7), carry(6), Sumado(7), carry(7)
        );

        u_soma8 : somador port map (
            Asum(8), Bsum(8), carry(7), Sumado(8), carry(8)
        );

        u_soma9 : somador port map (
            Asum(9), Bsum(9), carry(8), Sumado(9), carry(9)
        );

        u_soma10 : somador port map (
            Asum(10), Bsum(10), carry(9), Sumado(10), carry(10)
        );

        u_soma11 : somador port map (
            Asum(11), Bsum(11), carry(10), Sumado(11), Cout
        );
  




    end architecture;

