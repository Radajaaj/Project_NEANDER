library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_NOT is
  port (
    EnterNOT    : in  std_logic_vector(2 downto 0);
    SaidaNOT    : out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archNOT of Mod_UC_NOT is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterNOT(2);
  b1            <= EnterNOT(1);
  b0            <= EnterNOT(0);

  SaidaLda(10)  <= '1';                                     --barr/inc
  SaidaLda(9)   <= '1';                                     --barr/PC
  SaidaLda(8)   <= '0';                                     --ULA_op
  SaidaLda(7)   <= '0';                                     --ULA_op
  SaidaLda(6)   <= '0';                                     --ULA_op
  SaidaLda(5)   <= (not(b2) and not(b1) and b0);            --PC_rw
  SaidaLda(4)   <= (b2 and b1 and b0);                      --AC_rw
  SaidaLda(3)   <= '0';                                     --MEM_rw
  SaidaNop(2)   <= (not(b2 and b1 and b0));                 --REM_rw
  SaidaNop(1)   <= (not(b2) and not(b1) and b0);            --RDM_rw
  SaidaNop(0)   <= (not(b2) and b1 and not(b0));            --RI_rw
end architecture ;