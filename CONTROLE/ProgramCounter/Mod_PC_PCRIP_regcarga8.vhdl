library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCRIP8 is
  port (
    d : in std_logic_vector(7 downto 0);
    Clock : in std_logic;
    Preset, Clear : in std_logic;
    nrw : in std_logic;
    s : out std_logic_vector(7 downto 0)
  ) ;
end entity;

architecture ripagem of PCRIP8 is

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

    u_Reg_1 : regCarga1 port map(d(0), Clock, Preset, Clear, nrw, s(0));
    u_Reg_2 : regCarga1 port map(d(1), Clock, Preset, Clear, nrw, s(1));
    u_Reg_3 : regCarga1 port map(d(2), Clock, Preset, Clear, nrw, s(2));
    u_Reg_4 : regCarga1 port map(d(3), Clock, Preset, Clear, nrw, s(3));
    u_Reg_5 : regCarga1 port map(d(4), Clock, Preset, Clear, nrw, s(4));
    u_Reg_6 : regCarga1 port map(d(5), Clock, Preset, Clear, nrw, s(5));
    u_Reg_7 : regCarga1 port map(d(6), Clock, Preset, Clear, nrw, s(6));
    u_Reg_8 : regCarga1 port map(d(7), Clock, Preset, Clear, nrw, s(7));
    
end architecture;