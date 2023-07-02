library ieee;
use ieee.std_logic_1164.all;

entity ULA_tudo is 
  port(
    interface_barramento : inout std_logic_vector(7 downto 0);
    mem_rw : in std_logic;
    AC_rw  : in std_logic;
    ULA_op : in std_logic_vector(2 downto 0);
    preset : in std_logic;
    clk    : in std_logic;
    interface_flags : out std_logic_vector(1 downto 0)
  );
end ULA_tudo;

architecture ULAGEM of ULA_tudo is

----Registrador de 8 bits, vulgo AC------
    component reg8bits is
        port (
          d : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        ) ;
      end component; 

----Registrador de 2 bits, vulgo FLAGS------
      component reg2bits is
        port (
          d : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(1 downto 0)
        ) ;
      end component; 

----ULA, vulgo ULinha------
    component ULA is
        port (
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        ULA_op : in std_logic_vector(2 downto 0);
        Saida_ULA : out std_logic_vector(7 downto 0);
        NZ : out std_logic_vector(1 downto 0)
        );
    end component; 
   
  signal s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0);
  signal s_ac2flags : std_logic_vector(1 downto 0);

begin

  interface_barramento <= s_ac2ula when mem_rw='1' else (others => 'Z');
  
  u_ULA   : ULA      port map(s_ac2ula, interface_barramento, ULA_op, s_ula2ac, s_ac2flags);
  u_AC    : reg8bits port map(s_ula2ac, clk, '1', preset, AC_rw, s_ac2ula);
  u_FLAGS : reg2bits port map(s_ac2flags, clk, '1', preset, AC_rw, interface_flags);

end architecture;