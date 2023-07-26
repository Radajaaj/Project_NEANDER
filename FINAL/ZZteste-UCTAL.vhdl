library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity teste023 is
end teste023 ; 

architecture arcashrr of teste023 is
    constant CLK_PERIOD : time:= 10 ns;


    component UC is
        port (
          EnterDecode     : in std_logic_vector(10 downto 0);
          FlagsNZ         : in std_logic_vector(1 downto 0);
          clk             : in std_logic;
          cl              : in std_logic;
          barrControle    : out std_logic_vector(10 downto 0)
        );
    end component ; 
      

    signal s_ED :  std_logic_vector(10 downto 0);
    signal s_Fl  :  std_logic_vector(1 downto 0);
    signal s_clk : std_logic:= '1' ;
    signal s_cl : std_logic;
    signal s_bC : std_logic_vector(10 downto 0);
begin

    TESTE: UC port map (s_ED, s_Fl, s_clk, s_cl, s_bC);

    u_reset : process
    begin

        s_ed <= "10000000000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "01000000000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00100000000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00010000000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00001000000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000100000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000010000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000001000";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000000100";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000000100";
        s_fl <= "10";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000000010";
        s_fl <= "00";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000000010";
        s_fl <= "01";
        s_cl <= '1';
        wait for CLK_PERIOD;

        s_ed <= "00000000001";
        s_fl <= "01";
        s_cl <= '1';
        wait for CLK_PERIOD;



    end process;


    p_clock : process 
        begin
            s_clk <= not(s_clk);
            wait for CLK_PERIOD/2;
        end process;
        
end architecture ;