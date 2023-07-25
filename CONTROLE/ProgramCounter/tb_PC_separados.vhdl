library ieee;
use ieee.std_logic_1164.all;

entity tb_PCsep is
end entity;
 
architecture tbazem of tb_PCsep is

    constant CLK_PERIOD : time := 20 ns;

    component somador8bits_PC is
        port (
            Asum   : in  std_logic_vector (7 downto 0);
            Bsum   : in  std_logic_vector (7 downto 0);
            Cin    : in  std_logic;
            Sumado : out std_logic_vector (7 downto 0);
            Cout   : out std_logic
        );
    end component;

    component PCRIP is
        port (
            d : in std_logic_vector(7 downto 0);
            Clock : in std_logic;
            Preset, Clear : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector(7 downto 0)
        );
    end component;

    component mux2x8 is port
    (
        A : in std_logic_vector (7 downto 0);
        B : in std_logic_vector (7 downto 0);
        sel : in std_logic;
        S : out std_logic_vector (7 downto 0)
    );
    end component;

    signal sclk : std_logic := '1';

    signal barr, sadd, s_PCatual, s_mux2pc, s_endPC2MEM : std_logic_vector (7 downto 0);
    signal nbarrinc, PC_rw, cl, scout : std_logic;

begin
    s_endPC2MEM <= s_PCatual;
    u_mux   : mux2x8 port map(sadd, barr, nbarrinc, s_mux2pc);
    u_pcrip : PCRIP  port map(s_mux2pc, sclk, '1', cl, PC_rw, s_endPC2MEM);
    u_somador8bits_PC : somador8bits_PC port map("00000000", s_PCatual, '1', sadd, scout);

    u_armando : process
    begin
        s_PCatual   <= "00000000";
        s_endPC2MEM <= "00000000";
        barr <= "01101001";
        cl <= '1';

        nbarrinc <= '0';
        PC_rw   <= '0';
        wait for 3*CLK_PERIOD;

        nbarrinc <= '0';
        PC_rw   <= '1';
        wait for 3*CLK_PERIOD;

        nbarrinc <= '1';
        PC_rw   <= '0';
        wait for 3*CLK_PERIOD;

        nbarrinc <= '1';
        PC_rw   <= '1';
        wait for 3*CLK_PERIOD;

        wait for 10*CLK_PERIOD;

    end process;

    p_clock_n : process
    begin

        sclk <= not(sclk);
        wait for CLK_PERIOD/2;

    end process;

end architecture;