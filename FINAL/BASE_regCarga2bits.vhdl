library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg2bits is
  port (
    d : in std_logic_vector(1 downto 0);
    Clock : in std_logic;
    Preset, Clear : in std_logic;
    nrw : in std_logic;
    s : out std_logic_vector(1 downto 0)
  ) ;
end entity ; 

architecture hard of reg2bits is

    component regCarga1bit is
        port(
            d : in std_logic;
            clk : in std_logic;
            pr, cl : in std_logic; 
            nrw : in std_logic;
            s : out std_logic
            );
    end component;

    signal Saida, Entrada: std_logic_vector(1 downto 0);
begin
    Entrada <= d;
    Reg_1 : regCarga1bit port map (Entrada(0), Clock, Clear, Preset, nrw, s(0));
    Reg_2 : regCarga1bit port map (Entrada(1), Clock, Preset, Clear, nrw, s(1));
    
end architecture ;