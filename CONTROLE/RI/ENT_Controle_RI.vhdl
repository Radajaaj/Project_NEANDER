library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RIm is
  port (
    RI : in std_logic_vector(7 downto 0);
    Clock : in std_logic;
    Preset, Clear : in std_logic;
    nrw : in std_logic;
    s : out std_logic_vector(7 downto 0)
  ) ;
end entity; 
 
architecture archrim of RIm is

    component regCarga1 is
        port(
            d : in std_logic;
            clk : in std_logic;
            pr, cl : in std_logic; 
            nrw : in std_logic;
            s : out std_logic
            );
    end component;

begin
    Reg_1 : regCarga1 port map (RI(0), Clock, Preset, Clear, nrw, s(0));
    Reg_2 : regCarga1 port map (RI(1), Clock, Preset, Clear, nrw, s(1));
    Reg_3 : regCarga1 port map (RI(2), Clock, Preset, Clear, nrw, s(2));
    Reg_4 : regCarga1 port map (RI(3), Clock, Preset, Clear, nrw, s(3));
    Reg_5 : regCarga1 port map (RI(4), Clock, Preset, Clear, nrw, s(4));
    Reg_6 : regCarga1 port map (RI(5), Clock, Preset, Clear, nrw, s(5));
    Reg_7 : regCarga1 port map (RI(6), Clock, Preset, Clear, nrw, s(6));
    Reg_8 : regCarga1 port map (RI(7), Clock, Preset, Clear, nrw, s(7));
    
end architecture ;