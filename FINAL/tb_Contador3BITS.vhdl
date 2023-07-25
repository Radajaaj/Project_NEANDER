library ieee;
use ieee.std_logic_1164.all;

entity tb_contador is
end entity;
 
architecture conza of tb_contador is

    constant CLK_PERIOD : time := 20 ns;

    component contador3bits is
        port(
            clk   : in  std_logic;
            RESET : in  std_logic;
            VCC   : in  std_logic; 
            Sai   : out std_logic_vector (2 downto 0)
        );
    end component;

    signal sRESET, sVCC : std_logic;
    signal sSai : std_logic_vector (2 downto 0);
    signal sclk : std_logic := '1';

begin

    u_contador : contador3bits port map (sclk, sRESET, sVCC, sSai);

    u_reset : process
    begin
        sVCC   <= '1';
        sRESET <= '0';
        
        wait for CLK_PERIOD;

        sRESET <= '1';

        wait for 10*CLK_PERIOD;

    end process;

    p_clock_n : process
    begin

        sclk <= not(sclk);
        wait for CLK_PERIOD/2;

    end process;

end architecture;