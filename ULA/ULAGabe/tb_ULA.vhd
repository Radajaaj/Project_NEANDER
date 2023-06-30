library IEEE;
use ieee.std_logic_1164.all;

entity tb_ULA is 
end tb_ULA;

architecture hard of tb_ULA is 
    component ULA is
        port (
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        ULA_op : in std_logic_vector(2 downto 0);
        Saida_ULA : out std_logic_vector(7 downto 0);
        NZ : out std_logic_vector(1 downto 0)
        );
    end component ; 

    signal  sinal_X, sinal_Y, sinal_saida: std_logic_vector(7 downto 0);
    signal  sinal_ulaop: std_logic_vector(2 downto 0);
    signal  sinal_NZ: std_logic_vector(1 downto 0);

begin
    U_ULA : ULA port map (sinal_X, sinal_Y, sinal_ulaop, sinal_saida, sinal_NZ);

    tbp : process
    begin

        sinal_X <= "01000000";
        sinal_Y <= "01000000";
        sinal_ulaop <= "100";
        wait for 20 ns;

        sinal_X <= "01000000";
        sinal_Y <= "01000000";
        sinal_ulaop <= "011";
        wait for 20 ns;

        sinal_X <= "01000000";
        sinal_Y <= "01000000";
        sinal_ulaop <= "010";
        wait for 20 ns;

        sinal_X <= "01000000";
        sinal_Y <= "01000000";
        sinal_ulaop <= "001";
        wait for 20 ns;

        sinal_X <= "01000000";
        sinal_Y <= "01000000";
        sinal_ulaop <= "000";
        wait for 20 ns;
    end process;

        
        end architecture hard;