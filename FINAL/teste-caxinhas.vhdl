library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity teste001 is
end teste001 ; 

architecture archrr of teste001 is

    component Mod_UC_JMPNZ is
        port (
          EnterJMPNZ    : in  std_logic_vector(2 downto 0);
          SaidaJMPNZ    : out std_logic_vector(10 downto 0)
        );
      end component; 

    signal S_enterJMPNZ :  std_logic_vector(2 downto 0);
    signal  Saida_JMPNZ  :  std_logic_vector(10 downto 0);
begin

    TESTE: Mod_UC_JMPNZ port map (S_enterJMPNZ, Saida_JMPNZ);

    u_reset : process
    begin
       
        
        S_enterJMPNZ <= "000";
        wait for 20 ns;

       
        S_enterJMPNZ <= "001";
        wait for 20 ns;

         
        S_enterJMPNZ <= "010";
        wait for 20 ns;

         
        S_enterJMPNZ <= "011";
        wait for 20 ns;

         
        S_enterJMPNZ <= "100";
        wait for 20 ns;

         
        S_enterJMPNZ <= "101";
        wait for 20 ns;

         
        S_enterJMPNZ <= "110";
        wait for 20 ns;

         
        S_enterJMPNZ <= "111";
        wait for 20 ns;
        wait for 20 ns;

    end process;

end architecture ;