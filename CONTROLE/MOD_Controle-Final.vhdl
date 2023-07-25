library ieee ;
use ieee.std_logic_1164.all ;
  

entity ControleAll is
  port (
    Barramento_PC : in std_logic_vector(7 downto 0);
    Barramento_RI : in std_logic_vector(7 downto 0);
    Flags_NZ : in std_logic_vector(1 downto 0);
    Clock : in std_logic;
    Clear : in std_logic;
    Barramento_Controle : out std_logic_vector(7 downto 0);
  );
end entity; 

architecture arch of ControleAll is

    component decodificador is 
        port(
            instrin  : in  std_logic_vector(7 downto 0);
            instrout : out std_logic_vector(10 downto 0)
        );
    end component;

    component PC is
        port (
            barr        : in std_logic_vector (7 downto 0);
            nbarrinc    : in std_logic;
            PC_rw       : in std_logic;
            cl, clk     : in std_logic;
            s_endPC2MEM : out std_logic_vector (7 downto 0)
        );
  end component;
  
    component RIm is
        port (
            RI              : in std_logic_vector(7 downto 0);
            Clock           : in std_logic;
            Preset, Clear   : in std_logic;
            nrw             : in std_logic;
            s               : out std_logic_vector(7 downto 0)
        );
    end component; 

  component UC is
        port (
            EnterDecode     : in std_logic_vector(10 downto 0);
            FlagsNZ         : in std_logic_vector(1 downto 0);
            clk             : in std_logic;
            cl              : in std_logic;
            barrControle    : out std_logic_vector(10 downto 0)
        );
  end component; 

    signal Barramento_Dados : std_logic_vector(7 downto 0);
    signal Saida_PC, Saida_RI : std_logic_vector(7 downto 0);
    signal Saida_Decode : std_logic_vector(10 downto 0);
    
begin
    Barramento_PC <= Barramento_Dados;
    Barramento_RI <= Barramento_Dados;

    u_PC : PC port map (Barramento_PC, Barramento_Controle(10), Barramento_Controle(5), Clear, Clock , Saida_PC);
    u_RI : RIm port map (Barramento_RI, Clock, '1', Clear, Barramento_Controle(0), Saida_RI);
    u_DEC : decodificador port map (Saida_RI, Saida_Decode);
    u_UC : UC port map (Saida_Decode, Flags_NZ, Clock, Clear, Barramento_Controle);

end architecture ;