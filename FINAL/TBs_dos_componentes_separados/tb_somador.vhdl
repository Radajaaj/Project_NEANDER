library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_somador is
end entity;
 
architecture somancia of tb_somador is

    component somador8bits_PC is
        port(
            Asum   : in  std_logic_vector (7 downto 0);
            Bsum   : in  std_logic_vector (7 downto 0);
            Cin    : in  std_logic;
            Sumado : out std_logic_vector (7 downto 0);
            Cout   : out std_logic
        );
    end component;

    signal scout : std_logic;
    signal scin  : std_logic := '0';
    signal sA, sB, sSai : std_logic_vector (7 downto 0);

begin
 
    u_somador : somador8bits_PC port map (sA, sB, scin, sSai, scout);

    u_armando : process
    begin
        sA   <= x"00";
        sB   <= x"FF";
        wait for 20 ns;

--0xFFF 0x001
        sA   <= x"FF";
        sB   <= x"00";
        wait for 20 ns;

--0xFFE 0xFFE
        sA   <= x"FF";
        sB   <= x"FF";
        wait for 20 ns;

--0x0FF 0x0FF
        sA   <= x"0F";
        sB   <= x"0F";
        wait for 20 ns;

--0xABC 0xABC
        sA   <= x"AB";
        sB   <= x"AB";
        wait for 20 ns;

--0xCBA 0xABC
        sA   <= x"CB";
        sB   <= x"AB";
        wait for 20 ns;

--0x123 0xABC
        sA   <= x"12";
        sB   <= x"AB";
        wait for 20 ns;

    wait;
    end process;

end architecture;