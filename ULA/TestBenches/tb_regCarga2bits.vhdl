library IEEE;
use ieee.std_logic_1164.all;
 
entity tb_regCarga2bits is 
    --Entidade vazia
end tb_regCarga2bits;

architecture reg of tb_regCarga2bits is 
    constant CLK_PERIOD : time:= 20 ns;

    component reg2bits is
        port (
          d : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(1 downto 0)
        ) ;
      end component ; 

    signal Sig_Preset, Sig_Clear, Sig_nrw : std_logic;
    signal Sig_d, Sig_s : std_logic_vector(1 downto 0);
    signal Sig_Clock : std_logic:= '1' ;

begin
    u_reg8 : reg2bits port map (Sig_d, Sig_Clock, Sig_Preset, Sig_Clear, Sig_nrw, Sig_s);

    tbp : process
    begin
       
        Sig_d <= "00";
        Sig_Preset <= '1';
        Sig_Clear <= '0';
        Sig_nrw <= '0';
        wait for CLK_PERIOD;
        
        Sig_d <= "01";
        Sig_Clear <= '1';
        Sig_nrw <= '1';
       
        wait for CLK_PERIOD;

        Sig_d <= "10";
        Sig_nrw <= '0';
        wait for CLK_PERIOD;

        Sig_d <= "11";
        Sig_nrw <= '1';
        wait for CLK_PERIOD;

        Sig_d <= "00";
        Sig_nrw <= '0';
        wait for CLK_PERIOD;
    

        end process;

        p_clock : process 
        begin
            Sig_Clock<= not(Sig_Clock);
            wait for CLK_PERIOD/2;
        end process;

        end architecture reg;