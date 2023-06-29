library ieee;
use ieee.std_logic_1164.all;

entity tb_somador8bits is
end entity;

architecture soma8bits of tb_somador8bits is

    component somador8bits is
        port(
            Asum   : in  std_logic_vector (7 downto 0);
            Bsum   : in  std_logic_vector (7 downto 0);
            Cin    : in  std_logic;
            Sumado : out std_logic_vector (7 downto 0);
            Cout   : out std_logic
        );
    end component;


    signal s_B, s_A, s_Som    : std_logic_vector (7 downto 0);
    signal s_Carry, s_Cout         : std_logic;

begin
    u_somador  : somador8bits port map (s_A, s_B, s_Carry, s_Som, s_Cout);

    u_tb : process
    begin
--0x000 0xFFF
        s_A   <= x"000";
        s_B <= x"FFF";
        s_Carry  <= '0';
        wait for 20 ns; 

    wait;
    end process;
end architecture;