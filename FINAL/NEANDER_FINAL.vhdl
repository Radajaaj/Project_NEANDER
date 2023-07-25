library ieee;
use ieee.std_logic_1164.all;

entity NEANDER is
  port (
    Clock: in std_logic;
    Resetar : in std_logic
  );
end entity; 

architecture ArchNeander of NEANDER is
   
------------------------ULA----------------------------------------
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

------------------------MEMÓRIA-------------------------------------
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
------------------------CONTROLE------------------------------------
    component ControleAll is
      port (
        Barramento_PC : in std_logic_vector(7 downto 0);
        Barramento_RI : in std_logic_vector(7 downto 0);
        Flags_NZ : in std_logic_vector(1 downto 0);
        Clock : in std_logic;
        Clear : in std_logic;
        PC_out : out std_logic_vector(7 downto 0);
        Barramento_Controle : out std_logic_vector(10 downto 0)
      );

------------------------SIGNALS-------------------------------------

  signal Barramento_Principal : std_logic_vector(7 downto 0);
  signal Barramento_Controle : std_logic_vector(10 downto 0);
  signal end_out_PC : std_logic_vector(7 downto 0);
  signal end_out_MEM : std_logic_vector(7 downto 0);
  signal FLAGS_NZ : std_logic_vector(1 downto 0);
    
    
begin
  u_ULA : ULA_tud port map (Barramento_Principal, barramento_Controle(3), barramento_Controle(4), barramento_Controle(8 downto 6), Resetar, Clock, FLAGS_NZ);

  u_MEMORIA : modulo_Mem port map (end_out_PC, Barramento_Principal, barramento_Controle(9), barramento_Controle(2), barramento_Controle(3), barramento_Controle(1), Resetar, Clock, Barramento_Principal);
  
  u_CONTROLE : ControleAll port map (Barramento_Principal, Barramento_Principal, FLAGS_NZ, Clock, Resetar, end_out_PC, Barramento_Controle); 


end architecture ;