library IEEE;
use ieee.std_logic_1164.all;

entity modulo_Mem is port
(
    end_PC   : in std_logic_vector(7 downto 0);
    end_Barr : in std_logic_vector(7 downto 0);
    nBarrPC  : in std_logic;
    REM_rw   : in std_logic;
    MEM_rw   : in std_logic;
    RDM_rw   : in std_logic;
    reset    : in std_logic;
    clk      : in std_logic;
    interface_barramento : inout std_logic_vector(7 downto 0)
);
end entity;

architecture memoriando of modulo_Mem is
    
    component mux2x8 is port
    (
        Bar : in std_logic_vector(7 downto 0 ) ;
        PC : in std_logic_vector(7 downto 0 ) ;
        sel : in std_logic;
        S : out std_logic_vector(7 downto 0 )
    );
    end component;

    component Reg_REM is
        port (
          re_m : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        );
    end component; 

    component Reg_RDM is
        port (
          rdm : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        );
    end component; 

    component as_ram is
        port(
            addr  : in    std_logic_vector(7 downto 0); --ENDin
            data  : inout std_logic_vector(7 downto 0); --DATAinout
            notrw : in    std_logic; --MEM_rw
            reset : in    std_logic  --cl
        );
    end component as_ram;

    signal s_mux2rem, s_rem2mem, s_mem2rdm, s_rdm2barramento : std_logic_vector(7 downto 0); 

    begin
        interface_barramento <= s_rdm2barramento when MEM_rw  =  '0'
                                                 else (others => 'Z');

        s_mem2rdm  <= interface_barramento when MEM_rw  =  '1'
                                           else (others => 'Z');
        
        u_Mux2x8  : mux2x8  port map(end_Barr, end_PC, nBarrPC, s_mux2rem);
        u_REM     : Reg_REM port map(s_mux2rem, clk, '1', reset, REM_rw, s_rem2mem);
        u_Memoria : as_ram  port map(s_rem2mem, s_mem2rdm, MEM_rw, reset);
        u_RDM     : Reg_RDM port map(s_mem2rdm, clk, '1', reset, RDM_rw, s_rdm2barramento);

end architecture;