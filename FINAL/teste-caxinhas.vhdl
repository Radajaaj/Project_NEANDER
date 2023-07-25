library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity teste023 is
end teste023 ; 

architecture arcashrr of teste023 is

    entity UC is
        port (
          EnterDecode     : in std_logic_vector(10 downto 0);
          FlagsNZ         : in std_logic_vector(1 downto 0);
          clk             : in std_logic;
          cl              : in std_logic;
          barrControle    : out std_logic_vector(10 downto 0)
        );
    end entity ; 
      

    signal s_ED :  std_logic_vector(10 downto 0);
    signal  s_Fl  :  std_logic_vector(1 downto 0);
    signal s_clk : std_logic;
    signal s_cl : std_logic;
    signal s_bC : std_logic_vector(10 downto 0);
begin

    TESTE: Mod_UC_JMPNZ port map (s_ED, s_Fl, s_clk, s_cl, s_bC);

    u_reset : process
    begin
       
        
        S_enterJMPNZ <= "000";
        wait for 20 ns;

        s_ed <= "000000000000";
        s_fl <= "00";
        

    end process;


    p_clock : process 
        begin
            sclk <= not(sclk);
            wait for CLK_PERIOD/2;
        end process;
        
end architecture ;