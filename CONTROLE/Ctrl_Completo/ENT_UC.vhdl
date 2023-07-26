library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UC is 
port(
   EnterDecode     : in std_logic_vector(10 downto 0);
   FlagsNZ         : in std_logic_vector(1 downto 0);
   clk             : in std_logic;
   cl              : in std_logic;
   barrControle    : out std_logic_vector(10 downto 0)
);
end entity;

architecture archUC of UC is

    component contador3bits is 
    port(
        clk   : in  std_logic;
        RESET : in  std_logic;
        VCC   : in  std_logic; 
        Sai   : out std_logic_vector (2 downto 0)
    );
    end component;
    
    component Mod_UC_NOP is
        port (
          EnterNOP: in  std_logic_vector(2 downto 0);
          SaidaNOP: out std_logic_vector(10 downto 0)
        );
    end component;

    component Mod_UC_STA is
        port (
          EnterSTA: in  std_logic_vector(2 downto 0);
          SaidaSTA: out std_logic_vector(10 downto 0)
        );
    end component; 

    component Mod_UC_LDA is
        port (
          EnterLDA    : in  std_logic_vector(2 downto 0);
          EnterDecod  : in  std_logic_vector(10 downto 0);
          SaidaLDA    : out std_logic_vector(10 downto 0)
        );
    end component; --é LDA, ADD, AND e OR!

    component Mod_UC_NOT is
        port (
          EnterNOT    : in  std_logic_vector(2 downto 0);
          SaidaNOT    : out std_logic_vector(10 downto 0)
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

    component Mod_UC_HLT is
        port (
          EnterHLT    : in  std_logic_vector(2 downto 0);
          SaidaHLT    : out std_logic_vector(10 downto 0)
        );
    end component; 


    
    
    
    begin


end architecture;
