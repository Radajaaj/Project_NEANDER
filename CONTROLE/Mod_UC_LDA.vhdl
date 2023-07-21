library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_LDA is
  port (
    EnterLDA    : in  std_logic_vector(2 downto 0);
    EnterDecod  : in  std_logic_vector(10 downto 0);
    SaidaLDA    : out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archLDA of Mod_UC_LDA is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterLDA(2);
  b1            <= EnterLDA(1);
  b0            <= EnterLDA(0);

  SaidaLda(10)  <= '1';                                                                                       --barr/inc
  SaidaLda(9)   <= not(b2 and not(b1) and b0);                                                                --barr/PC
  SaidaLda(8)   <= '0';                                                                                       --ULA_op
  SaidaLda(7)   <= '1' when EnterDecod = "00001000000" else '1' when EnterDecod = "00000100000" else '0';     --ULA_op
  SaidaLda(6)   <= '1' when EnterDecod = "00010000000" else '1' when EnterDecod = "00000100000" else '0';     --ULA_op
  SaidaLda(5)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));                              --PC_rw
  SaidaLda(4)   <= (b2 and b1 and b0);                                                                        --AC_rw
  SaidaLda(3)   <= '0';                                                                                       --MEM_rw
  SaidaLda(2)   <= (not(b2) and not(b1) not(b0)) or (not(b2) and b1 and b0) or (b2 and not(b1) and b0);       --REM_rw
  SaidaLda(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b0));                                          --RDM_rw
  SaidaLda(0)   <= (not(b2) and b1 and not(b0));                                                              --RI_rw
end architecture ;