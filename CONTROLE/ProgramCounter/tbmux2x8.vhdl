library ieee;
use ieee.std_logic_1164.all;

entity tb_mux is
end entity;
 
architecture tbuzemu of tb_mux is

    component mux2x8 is port
    (
        A : in std_logic_vector (7 downto 0);
        B : in std_logic_vector (7 downto 0);
        sel : in std_logic;
        S : out std_logic_vector (7 downto 0)
    );
    end component;

    signal ssel : std_logic;
    signal sA, sB, sS : std_logic_vector (7 downto 0);

begin
    
    u_mux : mux2x8 port map (sA, sB, ssel, sS);

    u_muxando : process
    begin
    
        sB   <= "11111111";
        sA   <= "01010101";
        ssel <= '0';
        wait for 10 ns;
        sB   <= "11111111";
        sA   <= "01010101";
        ssel <= '1';
        wait for 10 ns;
        sB   <= "11000001";
        sA   <= "01000001";
        ssel <= '1';
        wait for 10 ns;
        sB   <= "11100111";
        sA   <= "11110101";
        ssel <= '0';
        wait for 10 ns;

    end process;

end architecture;