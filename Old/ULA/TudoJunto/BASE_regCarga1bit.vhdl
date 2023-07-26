library ieee;
use ieee.std_logic_1164.all;

entity regCarga1bit is
    port(
        d : in std_logic;
        clk : in std_logic;
        pr, cl : in std_logic; 
        nrw : in std_logic;
        s : out std_logic
        );
end entity;

architecture reg1 of regCarga1bit is
    component FFJK_D is
        port(
            d      : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    component mux2x1 is 
        port(
            A : in std_logic ;
            B : in std_logic ;
            sel : in std_logic;
            H : out std_logic
        );
    end component;

    signal datain, dataout : std_logic; 
     
begin
    s <= dataout;
    u_mux : mux2x1 port map(dataout, d, nrw, datain);
    u_reg : FFJK_D port map(datain, clk, pr, cl, dataout);
   

end architecture;