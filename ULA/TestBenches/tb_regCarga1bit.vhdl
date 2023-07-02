library IEEE;
use ieee.std_logic_1164.all;

entity tb_regCarga1bit is 
    --Entidade vazia
end tb_regCarga1bit;

architecture test_rg of tb_regCarga1bit is 
    constant CLK_PERIOD : time:= 10 ns;

    component regCarga1bit is
        port(
            d : in std_logic;
            clk : in std_logic;
            pr, cl : in std_logic; 
            nrw : in std_logic;
            s : out std_logic
            );
    end component;

    signal  sd, spr, scl, snrw, ss : std_logic;
    signal sclk : std_logic:= '1' ;

begin
    u_reg1 : regCarga1bit port map (sd, sclk, spr, scl, snrw, ss);

    tbp : process
    begin
        sd <= '0';
        spr <= '1';
        scl <= '0';
        snrw <= '0';
        wait for CLK_PERIOD;

        sd <= '0';
        scl <= '1';
        snrw <= '1';
        wait for CLK_PERIOD;

        sd <= '1';
        snrw <= '0';
        wait for CLK_PERIOD;

        sd <= '1';
        snrw <= '1';
        wait for CLK_PERIOD;
        sd <= '0';
        snrw <= '0';
        wait for CLK_PERIOD;

        sd <= '0';
        snrw <= '1';
        wait for CLK_PERIOD;

        sd <= '0';
        snrw <= '0';
        wait for CLK_PERIOD;

        sd <= '0';
        snrw <= '0';
        wait for CLK_PERIOD;

        sd <= '0';
        snrw <= '1';
        wait for CLK_PERIOD;

        sd <= '0';
        snrw <= '0';
        wait for CLK_PERIOD;
        end process;

        p_clock : process 
        begin
            sclk <= not(sclk);
            wait for CLK_PERIOD/2;
        end process;

        end architecture test_rg;    