library IEEE;
use ieee.std_logic_1164.all;

entity tb_regCarga8bits is 
    --Entidade vazia
end tb_regCarga8bits;

architecture rg of tb_regCarga8bits is 
    constant CLK_PERIOD : time:= 20 ns;

    component reg8bits is
        port (
          d : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        ) ;
      end component ; 

    signal Sig_Preset, Sig_Clear, Sig_nrw : std_logic;
    signal Sig_d, Sig_s : std_logic_vector(7 downto 0);
    signal Sig_Clock : std_logic:= '1' ;

begin
    u_reg8 : reg8bits port map (Sig_d, Sig_Clock, Sig_Preset, Sig_Clear, Sig_nrw, Sig_s);

    tbp : process
    begin
       
        Sig_d <= "00001000";
        Sig_Preset <= '1';
        Sig_Clear <= '0';
        Sig_nrw <= '0';
        wait for CLK_PERIOD;
        
        Sig_d <= "00000010";
        Sig_Clear <= '1';
        Sig_nrw <= '1';
       
        wait for CLK_PERIOD;

        Sig_d <= "00001000";
        Sig_nrw <= '0';
        wait for CLK_PERIOD;

        Sig_d <= "00001000";
        Sig_nrw <= '1';
        wait for CLK_PERIOD;

        Sig_d <= "00000100";
        Sig_nrw <= '0';
        wait for CLK_PERIOD;
    

        end process;

        p_clock : process 
        begin
            Sig_Clock<= not(Sig_Clock);
            wait for CLK_PERIOD/2;
        end process;

        end architecture rg;