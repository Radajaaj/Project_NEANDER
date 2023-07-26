library ieee;
use ieee.std_logic_1164.all;
 
entity contador3bits is 
    port(
        clk   : in  std_logic;
        RESET : in  std_logic;
        VCC   : in  std_logic; 
        Sai   : out std_logic_vector (2 downto 0)
    );
end entity;
 
architecture contagem of contador3bits is

    component FJK is
        port(
            j, k   : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    component ctrl is
        port(
        q : in  std_logic_vector(2 downto 0);
        j : out std_logic_vector(2 downto 0);
        k : out std_logic_vector(2 downto 0)
        );
    end component;

    signal Q, notQ : std_logic_vector (2 downto 0); 
    signal J, K    : std_logic_vector (2 downto 0); 

    begin
        u_ctrl : ctrl port map(
        Q, J, K
        );

        u_bit0 : FJK port map(
        J(0), K(0), clk, VCC, RESET, Q(0), notQ(0)
        );

        u_bit1 : FJK port map(
        J(1), K(1), clk, VCC, RESET, Q(1), notQ(1)
        );

        u_bit2 : FJK port map(
        J(2), K(2), clk, VCC, RESET, Q(2), notQ(2)
        );

        Sai <= Q;

end architecture;