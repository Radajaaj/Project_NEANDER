library ieee;
use ieee.std_logic_1164.all;

entity NEANDER is
  port (
    Clock: in std_logic;
    Resetar : in std_logic
  );
end entity; 

architecture ArchNeander of ent is
    component UC is
        port(
          EnterDecode     : in std_logic_vector(10 downto 0);
          FlagsNZ         : in std_logic_vector(1 downto 0);
          clk             : in std_logic;
          cl              : in std_logic;
          barrControle    : out std_logic_vector(10 downto 0)
        );
    end component ; 

    component modulo_Mem is 
        port(
            end_PC               : in std_logic_vector(7 downto 0);
            end_Barr             : in std_logic_vector(7 downto 0);
            nBarrPC              : in std_logic;
            REM_rw               : in std_logic;
            MEM_rw               : in std_logic;
            RDM_rw               : in std_logic;
            reset                : in std_logic;
            clk                  : in std_logic;
            interface_barramento : inout std_logic_vector(7 downto 0)
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
    end component ;

    component ULA_tud is 
        port(
            interface_barramento    : inout std_logic_vector(7 downto 0);
            mem_rw                  : in std_logic;
            AC_rw                   : in std_logic;
            ULA_op                  : in std_logic_vector(2 downto 0);
            reset                   : in std_logic;
            clk                     : in std_logic;
            interface_flags         : out std_logic_vector(1 downto 0)
        );
    end component;

    signal Barramento_Principal : std_logic_vector(7 downto 0);
    signal Barramento_Controle : std_logic_vector(10 downto 0);
    signal end_out_PC : std_logic_vector(7 downto 0);
    signal end_out_MEM : std_logic_vector(7 downto 0);
    
    
begin

    u_PC : PC port map (Barramento_Principal, barramento_Controle(10), barramento_Controle(5), Resetar, Clock, end_out_PC);--CORRIGIR PC!!!!!!

    u_MEMORIA : modulo_Mem port map (end_out_PC, Barramento_Principal, barramento_Controle(9), barramento_Controle(2), barramento_Controle(1), Resetar, Clock, end_out_MEM);

    u_ULA : ULA_tud port map (Barramento_Principal, barramento_Controle(3), barramento_Controle(4), barramento_Controle(8 downto 6), Resetar, Clock);
    
    u_UC : UC port map ();

end architecture ;