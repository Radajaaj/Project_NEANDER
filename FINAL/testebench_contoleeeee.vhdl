library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity teste022 is
end teste022 ; 

architecture arcashrr of teste022 is
    constant CLK_PERIOD : time:= 20 ns;


    component ControleAll is
        port (
          Barramento_PC : in std_logic_vector(7 downto 0);
          Barramento_RI : in std_logic_vector(7 downto 0);
          Flags_NZ : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Clear : in std_logic;
          PC_out : out std_logic_vector(7 downto 0);
          Barramento_Controle : out std_logic_vector(10 downto 0)
        );
      end component; 

      signal S_Barramento_PC, S_Barramento_RI, S_PC_out : std_logic_vector(7 downto 0);
      signal s_clk : std_logic:= '1' ;
      signal s_Clear : std_logic ;
      signal S_Barramento_Controle : std_logic_vector(10 downto 0);
      signal S_Flags_NZ : std_logic_vector(1 downto 0);
begin

    TESTE: ControleAll port map (S_Barramento_PC, S_Barramento_RI, S_Flags_NZ, s_clk, s_Clear, S_PC_out, S_Barramento_Controle);

    u_reset : process
    begin

        S_Barramento_RI <= "00010000";
        S_Barramento_PC <= "00010000";
        S_Flags_NZ <= "00";
        s_Clear <= '0';
        wait for CLK_PERIOD;

        S_Barramento_RI <= "00010000";
        S_Barramento_PC <= "00010000";
        S_Flags_NZ <= "00";
        s_Clear <= '1';
        wait for 8*CLK_PERIOD;

        S_Barramento_RI <= "00010000";
        S_Barramento_PC <= "00010000";
        S_Flags_NZ <= "00";
        wait for 8*CLK_PERIOD;

    end process;


    p_clock : process 
        begin
            s_clk <= not(s_clk);
            wait for CLK_PERIOD/2;
        end process;
        
end architecture ;