library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_NEANDER_separado is 
end entity;

architecture neandertown of tb_NEANDER_separado is

    constant CLK_PERIOD : time:= 20 ns;

    component ULA_tud is 
    port(
      interface_barramento : inout std_logic_vector(7 downto 0);
      mem_rw : in std_logic;
      AC_rw  : in std_logic;
      ULA_op : in std_logic_vector(2 downto 0);
      reset : in std_logic;
      clk    : in std_logic;
      interface_flags : out std_logic_vector(1 downto 0)
    );
    end component;

    component modulo_Mem is 
    port(
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
    end component;

    component ControleAll is
        port (
          Barramento_PC : in std_logic_vector(7 downto 0);
          Barramento_RI : in std_logic_vector(7 downto 0);
          Flags_NZ : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Clear : in std_logic;
          PC_out : out std_logic_vector(7 downto 0);
          Barramento_Controle : out std_logic_vector(10 downto 0)
        );
    end component;


        signal ctrl : std_logic_vector (10 downto 0);
        signal sbarramento, spc2mem : std_logic_vector(7 downto 0);
        signal flags2uc   : std_logic_vector(1 downto 0); --sNZ
        signal scl, TEMPNRW  : std_logic;
        signal sclk : std_logic := '1';
 
   
   --signal Sig_Resetar : std_logic;
   --signal Sig_Clock : std_logic:= '1';

begin 

    u_ULA  : ULA_tud     port map (sbarramento, ctrl(3), ctrl(4), ctrl(8 downto 6), scl, sclk, flags2uc);
                         --memrw, acrw, ulaop = 3, 4, 8 downto 6       ou    7, 6, (4 downto 2)
    u_MEM  : modulo_mem  port map (spc2mem, sbarramento, ctrl(9), ctrl(2), ctrl(3), ctrl(1), scl, sclk, sbarramento);        --nbarrpc, remrw, memrw, rdmrw 9, 2, 3, 1,    ou    1, 8, 7, 9
    u_CTRL : ControleAll port map (sbarramento, sbarramento, flags2uc, sclk, scl, spc2mem, ctrl);
     
    testandoobench : process
    begin
       
        scl <= '0';
        wait for CLK_PERIOD;
        
        scl <= '1';
        wait for 69420*CLK_PERIOD;
        wait;
        end process;

    p_clock_n : process
    begin
        sclk <= not(sclk);
        wait for CLK_PERIOD/2;
    end process;

end architecture;