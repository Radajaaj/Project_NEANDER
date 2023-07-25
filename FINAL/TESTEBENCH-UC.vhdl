library ieee;
use ieee.std_logic_1164.all;

entity tb_Controlao is
end entity;
 
architecture tbazems of tb_Controlao is
    constant CLK_PERIOD : time := 20 ns;

    component ControleAll is
        port (
          Barramento_PC : in std_logic_vector(7 downto 0);
          Barramento_RI : in std_logic_vector(7 downto 0);
          Flags_NZ : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Clear : in std_logic;
          OUT_PC : out std_logic_vector(7 downto 0);
          Barramento_Controle : out std_logic_vector(10 downto 0)
        );
    end component;

      signal S_clear :std_logic;
      signal S_Barramento_PC, S_Barramento_RI, S_out_PC :std_logic_vector(7 downto 0) ;
      signal S_FLAGS : std_logic_vector(1 downto 0);
      signal S_Barramento_Contole : std_logic_vector(10 downto 0) ;
      signal sclk : std_logic := '1';
      
      
begin

        U_contoleDocaralho : ControleALL port map (S_Barramento_PC, S_Barramento_RI, S_FLAGS, sclk, S_clear, S_out_PC, S_Barramento_Contole);

        u_armando : process
    begin
       
        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
        S_clear <= '0';
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
        S_clear <= '1';
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
        
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
        
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
       
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

        S_Barramento_PC <= "00000001";
        S_Barramento_RI <= "00001000";
      
        S_FLAGS <= "01";
        wait for CLK_PERIOD;

    end process;



    p_clock_n : process
    begin

        sclk <= not(sclk);
        wait for CLK_PERIOD/2;

    end process;

end architecture;