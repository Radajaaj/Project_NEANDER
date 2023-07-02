library ieee ;
    use ieee.std_logic_1164.all ;

entity reg8bits is
  port (
    d : in std_logic_vector(7 downto 0);
    Clock : in std_logic;
    Preset, Clear : in std_logic;
    nrw : in std_logic;
    s : out std_logic_vector(7 downto 0)
  ) ;
end entity ; 

architecture arch of reg8bits is

    component regCarga1bit is
        port(
            d : in std_logic;
            clk : in std_logic;
            pr, cl : in std_logic; 
            nrw : in std_logic;
            s : out std_logic
            );
    end component;

    signal Saida, Entrada: std_logic_vector(7 downto 0);
begin
    Entrada <= d;
    Reg_1 : regCarga1bit port map (Entrada(0), Clock, Preset, Clear, nrw, s(0));
    Reg_2 : regCarga1bit port map (Entrada(1), Clock, Preset, Clear, nrw, s(1));
    Reg_3 : regCarga1bit port map (Entrada(2), Clock, Preset, Clear, nrw, s(2));
    Reg_4 : regCarga1bit port map (Entrada(3), Clock, Preset, Clear, nrw, s(3));
    Reg_5 : regCarga1bit port map (Entrada(4), Clock, Preset, Clear, nrw, s(4));
    Reg_6 : regCarga1bit port map (Entrada(5), Clock, Preset, Clear, nrw, s(5));
    Reg_7 : regCarga1bit port map (Entrada(6), Clock, Preset, Clear, nrw, s(6));
    Reg_8 : regCarga1bit port map (Entrada(7), Clock, Preset, Clear, nrw, s(7));
    
end architecture ;