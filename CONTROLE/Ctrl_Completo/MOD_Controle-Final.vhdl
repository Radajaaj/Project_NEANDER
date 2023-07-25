library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControleAll is
    port (
      Barramento_PC : in std_logic_vector(7 downto 0);
      Barramento_RI : in std_logic_vector(7 downto 0);
      Flags_NZ : in std_logic_vector(1 downto 0);
      Clock : in std_logic;
      Clear : in std_logic;
      Barramento_Controle : out std_logic_vector(10 downto 0)
    );
end entity; 

architecture controlante of ControleAll is

    component PC_tudo is
        port(
          barr        : in std_logic_vector (7 downto 0);
          nbarrinc    : in std_logic;
          PC_rw       : in std_logic;
          cl, clk     : in std_logic;
          s_endPC2MEM : out std_logic_vector (7 downto 0)
        );
    end component;

    component RIm is
        port (
          RI : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        ) ;
    end component; 

    component decodificador is port
        (
            instrin  : in  std_logic_vector(7 downto 0);
            instrout : out std_logic_vector(10 downto 0)
        );
    end component;

    



    begin



end architecture;