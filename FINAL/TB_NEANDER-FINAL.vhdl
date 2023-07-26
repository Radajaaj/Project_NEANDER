library IEEE;
use ieee.std_logic_1164.all;

entity TB_NEANDER is 
end entity;

architecture Neanderzin of TB_NEANDER is 
    constant CLK_PERIOD : time:= 20 ns;

    component NEANDER is
        port (
          Clock: in std_logic;
          Resetar : in std_logic
        );
    end component; 
   
    signal Sig_Resetar : std_logic;
    signal Sig_Clock : std_logic:= '1';

begin
   
    U_Neander : NEANDER port map (Sig_Clock, Sig_Resetar);

    tbp : process
    begin
       
        Sig_Resetar <= '0';
        wait for CLK_PERIOD;
        
        Sig_Resetar <= '1';
        wait for 8*CLK_PERIOD;
        
        
        end process;

    p_clock : process 
    begin
        Sig_Clock<= not(Sig_Clock);
        wait for CLK_PERIOD/2;
    end process;

end architecture;