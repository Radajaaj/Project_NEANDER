library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
  port (
    EnterDecode     : in std_logic_vector(10 downto 0);
    FlagsNZ         : in std_logic_vector(1 downto 0);
    clk             : in std_logic;
    cl              : in std_logic;
    barrControle    : out std_logic_vector(10 downto 0)
  );
end entity ; 

architecture archUC of UC is

    component contador3bits is
        port(
            clk         : in  std_logic;
            RESET       : in  std_logic;
            VCC         : in  std_logic; 
            Sai         : out std_logic_vector (2 downto 0)
        );
    end component;

    component Mod_UC_HLT is
        port (
            EnterHLT    : in  std_logic_vector(2 downto 0);
            SaidaHLT    : out std_logic_vector(10 downto 0)
        );
    end component; 

    component Mod_UC_JMP is
        port (
            EnterJMP    : in  std_logic_vector(2 downto 0);
            SaidaJMP    : out std_logic_vector(10 downto 0)
        );
    end component; 

    component Mod_UC_JMPNZ is
        port (
            EnterJMPNZ    : in  std_logic_vector(2 downto 0);
            SaidaJMPNZ    : out std_logic_vector(10 downto 0)
        );
    end component;

    component Mod_UC_LDA is
        port (
            EnterLDA    : in  std_logic_vector(2 downto 0);
            EnterDecod  : in  std_logic_vector(10 downto 0);
            SaidaLDA    : out std_logic_vector(10 downto 0)
        );
    end component;

    component Mod_UC_NOP is
        port (
            EnterNOP    : in  std_logic_vector(2 downto 0);
            SaidaNOP    : out std_logic_vector(10 downto 0)
        );
    end component ; 

    component Mod_UC_NOT is
        port (
            EnterNOT    : in  std_logic_vector(2 downto 0);
            SaidaNOT    : out std_logic_vector(10 downto 0)
        );
    end component; 

    component Mod_UC_STA is
        port (
            EnterSTA    : in  std_logic_vector(2 downto 0);
            SaidaSTA    : out std_logic_vector(10 downto 0)
        );
    end component ; 
  

  signal sinal_DECODENZ : std_logic_vector(12 downto 0);
  signal sinal_cont     : std_logic_vector(2 downto 0);
  signal s_HLT          : std_logic_vector(10 downto 0);
  signal s_JMP          : std_logic_vector(10 downto 0);
  signal s_JMPNZ        : std_logic_vector(10 downto 0);
  signal s_LDA          : std_logic_vector(10 downto 0);
  signal s_NOP          : std_logic_vector(10 downto 0);
  signal s_NOT          : std_logic_vector(10 downto 0);
  signal s_STA          : std_logic_vector(10 downto 0);
  
begin

  sinal_DECODENZ(12 downto 11)  <= FlagsNZ;
  sinal_DECODENZ(10 downto 0)   <= EnterDecode;
  
  
  U_CONT    : contador3bits port map (clk, cl, '1', sinal_cont);
  U_HLT     : Mod_UC_HLT    port map (sinal_cont, s_HLT);
  U_JMP     : Mod_UC_JMP    port map (sinal_cont, s_JMP);
  U_JMPNZ   : Mod_UC_JMPNZ  port map (sinal_cont, s_JMPNZ);
  U_LDA     : Mod_UC_LDA    port map (sinal_cont, EnterDecode, s_LDA);
  U_NOP     : Mod_UC_NOP    port map (sinal_cont, s_NOP);
  U_NOT     : Mod_UC_NOT    port map (sinal_cont, s_NOT);
  U_STA     : Mod_UC_STA    port map (sinal_cont, s_STA);
  
  barrControle   <= s_HLT    when sinal_DECODENZ = "0000000000001" else
                  s_JMP      when sinal_DECODENZ = "0000000001000" else
                  s_JMP      when sinal_DECODENZ = "1000000000100" else
                  s_JMP      when sinal_DECODENZ = "0100000000010" else
                  s_JMPNZ    when sinal_DECODENZ = "0000000000100" else
                  s_JMPNZ    when sinal_DECODENZ = "0000000000010" else
                  s_NOP      when sinal_DECODENZ = "0010000000000" else
                  s_NOT      when sinal_DECODENZ = "0000000010000" else
                  s_STA      when sinal_DECODENZ = "0001000000000" else
                  s_LDA      when sinal_DECODENZ = "0000100000000" else
                  s_LDA      when sinal_DECODENZ = "0000010000000" else
                  s_LDA      when sinal_DECODENZ = "0000001000000" else
                  s_LDA      when sinal_DECODENZ = "0000000100000";

end architecture;