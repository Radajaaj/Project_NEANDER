library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity tb_decode is
end entity;
 
architecture conza of tb_decode is

    component decodificador is port
    (
        instrin  : in  std_logic_vector(7 downto 0);
        instrout : out std_logic_vector(10 downto 0)
    );
    end component;

    signal sEntra : std_logic_vector (7 downto 0);
    signal sSai   : std_logic_vector (10 downto 0);

begin

    u_decoder : decodificador port map (sEntra, sSai);

    u_reset : process
    begin

        sEntra <= "00000000";
        wait for 10 ns;
        sEntra <= "00010000";
        wait for 10 ns;
        sEntra <= "00100000";
        wait for 10 ns;
        sEntra <= "00110000";
        wait for 10 ns;
        sEntra <= "01000000";
        wait for 10 ns;
        sEntra <= "01010000";
        wait for 10 ns;
        sEntra <= "01100000";
        wait for 10 ns;
        sEntra <= "10000000";
        wait for 10 ns;
        sEntra <= "10010000";
        wait for 10 ns;
        sEntra <= "10100000";
        wait for 10 ns;
        sEntra <= "11110000";
        wait for 10 ns;
        
        sEntra <= "11111000";
        wait for 10 ns;
        sEntra <= "10011111";
        wait for 10 ns;
        sEntra <= "00000000";
        wait for 10 ns;
        sEntra <= "11111111";
        wait for 10 ns;
    end process;
end architecture;