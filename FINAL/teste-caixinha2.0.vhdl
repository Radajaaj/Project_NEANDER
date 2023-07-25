library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity teste002 is
end teste002 ; 

architecture archrr of teste002 is

    component Mod_UC_NOP is
        port (
          EnterNOP: in  std_logic_vector(2 downto 0);
          SaidaNOP: out std_logic_vector(10 downto 0)
        );
      end component ; 

    signal S_enterNOP :  std_logic_vector(2 downto 0);
    signal  Saida_NOP  :  std_logic_vector(10 downto 0);
begin

    TESTE: Mod_UC_NOP port map (S_enterNOP, Saida_NOP);

    u_reset : process
    begin
       
        
        S_enterNOP <= "000";
        wait for 20 ns;

       
        S_enterNOP <= "001";
        wait for 20 ns;

         
        S_enterNOP <= "010";
        wait for 20 ns;

         
        S_enterNOP <= "011";
        wait for 20 ns;

         
        S_enterNOP <= "100";
        wait for 20 ns;

         
        S_enterNOP <= "101";
        wait for 20 ns;

         
        S_enterNOP <= "110";
        wait for 20 ns;

         
        S_enterNOP <= "111";
        wait for 20 ns;
        wait for 20 ns;

    end process;

end architecture ;