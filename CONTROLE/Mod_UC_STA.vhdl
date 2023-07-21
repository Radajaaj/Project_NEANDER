library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_STA is
  port (
    EnterSTA: in  std_logic_vector(2 downto 0);
    SaidaSTA: out std_logic_vector(10 downto 0)
  );
end entity ; 

architecture archSTA of Mod_UC_STA is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterSTA(2);
  b1            <= EnterSTA(1);
  b0            <= EnterSTA(0);

  SaidaSta(10)  <= '1';                                                                                         --barr/inc
  SaidaSta(9)   <= (not(b2 and not(b1) and b0));                                                                --barr/PC
  SaidaSta(8)   <= '0';                                                                                         --ULA_op
  SaidaSta(7)   <= '0';                                                                                         --ULA_op
  SaidaSta(6)   <= '0';                                                                                         --ULA_op
  SaidaSta(5)   <= ((not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0)));                              --PC_rw
  SaidaSta(4)   <= '0';                                                                                         --AC_rw
  SaidaSta(3)   <= (b2 and b1 and not(b0));                                                                     --MEM_rw
  SaidaSta(2)   <= (not(b2) and not(b1) and not(b0)) or (not(b2) and b1 and b0) or (b2 and not(b1) and b0);     --REM_rw
  SaidaSta(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));                                --RDM_rw
  SaidaSta(0)   <= (not(b2) and b1 and not(b0));                                                                --RI_rw
end architecture ;