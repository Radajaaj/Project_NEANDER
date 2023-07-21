library ieee ;
use ieee.std_logic_1164.all ;
entity UC is
  port (
    EnterDecode     : in std_logic_vector(10 downto 0);
    FlagsNZ         : in std_logic_vector(1 downto 0);
    clk             : in std_logic;
    cl              : in std_logic;
    barrControle    : out std_logic_vector(10 downto 0);
  );
end entity ; 

architecture arch of ULA is

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
  
begin

  sinal_DECODENZ(12 downto 11)  <= FlagsNZ;
  sinal_DECODENZ(10 downto 0)   <= EnterDecode;
  sai                           <= sinal_cont;
  
  U_CONT    : contador3bits port map (clk, cl, '1');
  U_HLT     : Mod_UC_HLT    port map (sinal_cont);
  U_JMP     : Mod_UC_JMP    port map (sinal_cont);
  U_JMPNZ   : Mod_UC_JMPNZ  port map (sinal_cont);
  U_LDA     : Mod_UC_LDA    port map (sinal_cont, EnterDecode);
  U_NOP     : Mod_UC_NOP    port map (sinal_cont);
  U_NOT     : Mod_UC_NOT    port map (sinal_cont);
  U_STA     : Mod_UC_STA    port map (sinal_cont);
  
  barrControle <= saidaHLT      when sinal_DECODENZ = "0000000000001"
  barrControle <= saidaJMP      when sinal_DECODENZ = "0000000001000"
  barrControle <= saidaJMP      when sinal_DECODENZ = "1000000000100"
  barrControle <= saidaJMP      when sinal_DECODENZ = "0100000000010"  
  barrControle <= saidaJMPNZ    when sinal_DECODENZ = "0000000000100"
  barrControle <= saidaJMPNZ    when sinal_DECODENZ = "0000000000010"
  barrControle <= saidaNOP      when sinal_DECODENZ = "0010000000000"
  barrControle <= saidaNOT      when sinal_DECODENZ = "0000000010000"
  barrControle <= saidaSTA      when sinal_DECODENZ = "0001000000000"
  barrControle <= saidaLDA      when sinal_DECODENZ = "0000100000000"
  barrControle <= saidaLDA      when sinal_DECODENZ = "0000010000000"
  barrControle <= saidaLDA      when sinal_DECODENZ = "0000001000000"
  barrControle <= saidaLDA      when sinal_DECODENZ = "0000000100000"

  
end architecture ;