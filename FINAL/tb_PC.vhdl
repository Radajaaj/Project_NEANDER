library ieee;
use ieee.std_logic_1164.all;

entity tb_PC is
end entity;
 
architecture tbuzem of tb_PC is

    constant CLK_PERIOD : time := 20 ns;

    component PC_tudo is
        port(
          barr        : in std_logic_vector (7 downto 0);
          nbarrinc    : in std_logic;
          PC_rw       : in std_logic;
          cl, clk     : in std_logic;
          s_endPC2MEM : out std_logic_vector (7 downto 0)
        );
      end component;

    signal snbarrinc, sPC_rw, scl : std_logic;
    signal sclk : std_logic := '1';
    signal sbarr, ss_endPC2MEM : std_logic_vector (7 downto 0);

begin
 
    u_PCtb : PC_tudo port map (sbarr, snbarrinc, sPC_rw, scl, sclk, ss_endPC2MEM);

    u_armando : process
    begin
        sbarr <= "01101001";
        scl <= '1';

        snbarrinc <= '0';
        sPC_rw   <= '0';
        wait for 3*CLK_PERIOD;

        snbarrinc <= '0';
        sPC_rw   <= '1';
        wait for 3*CLK_PERIOD;

        snbarrinc <= '1';
        sPC_rw   <= '0';
        wait for 3*CLK_PERIOD;

        snbarrinc <= '1';
        sPC_rw   <= '1';
        wait for 3*CLK_PERIOD;

        wait for 10*CLK_PERIOD;

    end process;

    p_clock_n : process
    begin

        sclk <= not(sclk);
        wait for CLK_PERIOD/2;

    end process;

end architecture;