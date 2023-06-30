library ieee ;
use ieee.std_logic_1164.all ;
entity ULA is
  port (
    X : in std_logic_vector(7 downto 0);
    Y : in std_logic_vector(7 downto 0);
    ULA_op : in std_logic_vector(2 downto 0);
    Saida_ULA : out std_logic_vector(7 downto 0);
    NZ : out std_logic_vector(1 downto 0)
  );
end entity ; 

architecture arch of ULA is
  component mux5x8 is port(
      A : in std_logic_vector (7 downto 0); --NOT
      B : in std_logic_vector (7 downto 0);--AND
      C : in std_logic_vector (7 downto 0);--OR
      D : in std_logic_vector (7 downto 0);--ADD
      E : in std_logic_vector (7 downto 0);--LDA
      sel : in std_logic_vector (2 downto 0);--ULA_op
      H : out std_logic_vector(7 downto 0)--s_resultado
  );
  end component;

  component Detector_NZ is
    port (
      datain : in std_logic_vector(7 downto 0);
      dataout : out std_logic_vector(1 downto 0)--N e Z
    ); 
  end component;

  component somador8bit is
    port(
        Asum   : in  std_logic_vector (7 downto 0);
        Bsum   : in  std_logic_vector (7 downto 0);
        Cin    : in  std_logic;
        Sumado : out std_logic_vector (7 downto 0);
        Cout   : out std_logic
    );
  end component;

  signal sinal_not, sinal_add, sinal_and, sinal_or, sinal_lda, out_ula : std_logic_vector(7 downto 0);
  signal sinal_dataout : std_logic_vector(1 downto 0);
  
  
begin

  sinal_and <= X and Y;
  sinal_not <= not(X); 
  sinal_or <= X or Y;
  sinal_lda <= Y;
  
  Saida_ULA <= out_ula;
  
  U_soma : somador8bit port map (X, Y, '0', sinal_add);
  U_ULA : mux5x8 port map (sinal_not, sinal_and, sinal_or, sinal_add, sinal_lda, ULA_op, Saida_ULA);
  U_detc : Detector_NZ port map (out_ula, sinal_dataout );
  

end architecture ;