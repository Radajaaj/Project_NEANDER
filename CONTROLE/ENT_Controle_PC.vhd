library ieee ;
use ieee.std_logic_1164.all ;
entity PC is
  port (
    barr        : in std_logic_vector (7 downto 0);
    nbarrinc    : in std_logic;
    PC_rw       : in std_logic;
    cl, clk     : in std_logic;
    s_endPC2MEM : out std_logic_vector (7 downto 0)

  );
end entity ;

architecture programcounter of PC is
    component somador8bits_PC is
        port (
            Asum   : in  std_logic_vector (7 downto 0);
            Bsum   : in  std_logic_vector (7 downto 0);
            Cin    : in  std_logic;
            Sumado : out std_logic_vector (7 downto 0);
            Cout   : out std_logic
        );
        end component;

    component PCRIP is
        port (
            d : in std_logic_vector(7 downto 0);
            Clock : in std_logic;
            Preset, Clear : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector(7 downto 0)
        );
        end component;

signal s_sadd, s_mux2pc, s_PCatual, s_endPC2MEM_elo : std_logic_vector (7 downto 0);

begin

    s_mux2pc <= barr when nbarrinc = '0' else s_sadd;
    s_endPC2MEM_elo <= s_endPC2MEM;
    s_PCatual <= s_endPC2MEM_elo;

    U_soma : somador8bits_PC port map ("00000000", s_PCatual, '1', s_sadd);
    U_reg : PCRIP port map (s_mux2PC, clk, '1', cl, PC_rw, s_endPC2MEM_elo);

    end architecture;