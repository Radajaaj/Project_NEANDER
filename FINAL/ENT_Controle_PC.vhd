library ieee;
use ieee.std_logic_1164.all;

entity PC_tudo is
  port(
    barr        : in std_logic_vector (7 downto 0);
    nbarrinc    : in std_logic;
    PC_rw       : in std_logic;
    cl, clk     : in std_logic;
    s_endPC2MEM : out std_logic_vector (7 downto 0)
  );
end entity;

architecture programcounter of PCc is
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

    component mux2x8 is port
    (
        A : in std_logic_vector (7 downto 0);
        B : in std_logic_vector (7 downto 0);
        sel : in std_logic;
        S : out std_logic_vector (7 downto 0)
    );
    end component;

signal s_cout : std_logic;
signal sadd, s_mux2pc, s_PCatual : std_logic_vector (7 downto 0);

begin
    u_mux  : mux2x8 port map(sadd, barr, nbarrinc, s_mux2pc);
    u_soma : somador8bits_PC port map ("00000001", s_PCatual, '0', sadd, s_cout);
    u_reg  : PCRIP port map (s_mux2pc, clk, '1', cl, PC_rw, s_PCatual);
    
    s_endPC2MEM <= s_PCatual;
    
end architecture;