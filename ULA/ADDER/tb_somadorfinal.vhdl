library ieee;
use ieee.std_logic_1164.all;

entity tb_somadorfinal is
end entity;

architecture somareduz of tb_somadorfinal is

    component negador is
        port(
            Bnegara : in  std_logic_vector (11 downto 0);
            Bnegado : out std_logic_vector (11 downto 0)
    );
    end component;


    component mux2x12 is
        port(
            Bsim : in  std_logic_vector (11 downto 0);
            Bnao : in  std_logic_vector (11 downto 0);
            Op   : in  std_logic;
            Bout : out std_logic_vector (11 downto 0)
        );
    end component;


    component overflow is
        port(
            Aov : in std_logic;
            Bov : in std_logic;
            Sov : in std_logic;
            Ov : out std_logic
            );
    end component;


    component somador12bits is
        port(
            Asum   : in  std_logic_vector (11 downto 0);
            Bsum   : in  std_logic_vector (11 downto 0);
            Cin    : in  std_logic;
            Sumado : out std_logic_vector (11 downto 0);
            Cout   : out std_logic
        );
    end component;


    signal s_Bim,  s_Bao      : std_logic_vector (11 downto 0);
    signal s_Bmux, s_A, s_Som : std_logic_vector (11 downto 0);
    signal s_Op, s_Of, s_Cout : std_logic;

begin
    u_negador  : negador  port map (s_Bim, s_Bao);
    u_mux2x12  : mux2x12  port map (s_Bim, s_Bao, s_Op, s_Bmux);
    u_overflow : overflow port map (s_A(11), s_Bmux(11), s_Som(11), s_Of);
    u_somador  : somador12bits port map (s_A, s_Bmux, s_Op, s_Som, s_Cout);

    u_tb : process
    begin
--0x000 0xFFF
        s_A   <= x"000";
        s_Bim <= x"FFF";
        s_Op  <= '0';
        wait for 20 ns;

--0x000 0xFFF
        s_A   <= x"000";
        s_Bim <= x"FFF";
        s_Op  <= '1';
        wait for 20 ns;

--0xFFF 0x001
        s_A   <= x"FFF";
        s_Bim <= x"001";
        s_Op  <= '0';
        wait for 20 ns;

--0xFFF 0x001
        s_A   <= x"FFF";
        s_Bim <= x"001";
        s_Op  <= '1';
        wait for 20 ns;

--0xFFE 0xFFE
        s_A   <= x"FFE";
        s_Bim <= x"FFE";
        s_Op  <= '0';
        wait for 20 ns;

--0x0FF 0x0FF
        s_A   <= x"0FF";
        s_Bim <= x"0FF";
        s_Op  <= '0';
        wait for 20 ns;

--Algum caso intermediário
--0xABC 0xABC
        s_A   <= x"ABC";
        s_Bim <= x"ABC";
        s_Op  <= '0';
        wait for 20 ns;

--0xABC 0xABC
        s_A   <= x"ABC";
        s_Bim <= x"ABC";
        s_Op  <= '1';
        wait for 20 ns;

--0xCBA 0xABC
        s_A   <= x"CBA";
        s_Bim <= x"ABC";
        s_Op  <= '0';
        wait for 20 ns;

--0x123 0xABC
        s_A   <= x"123";
        s_Bim <= x"ABC";
        s_Op  <= '1';
        wait for 20 ns;

        s_A   <= x"123";
        s_Bim <= x"ABC";
        s_Op  <= '0';
        wait for 20 ns;

    wait;
    end process;
end architecture;