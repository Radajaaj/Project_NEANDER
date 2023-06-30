library IEEE;
use ieee.std_logic_1164.all;

entity ULA_tudo is 
  port(
    
  );
end ULA_tudo;

architecture hardware of tb_ULA is 
    constant CLK_PERIOD : time:= 20 ns;

----Registrador de 8 bits------
    component reg8bits is
        port (
          d : in std_logic_vector(7 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(7 downto 0)
        ) ;
      end component; 

----Registrador de 2 bits------
      component reg2bits is
        port (
          d : in std_logic_vector(1 downto 0);
          Clock : in std_logic;
          Preset, Clear : in std_logic;
          nrw : in std_logic;
          s : out std_logic_vector(1 downto 0)
        ) ;
      end component; 

----ULA------
    component ULA is
        port (
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        ULA_op : in std_logic_vector(2 downto 0);
        Saida_ULA : out std_logic_vector(7 downto 0);
        NZ : out std_logic_vector(1 downto 0)
        );
    end component; 
   
begin

end architecture;