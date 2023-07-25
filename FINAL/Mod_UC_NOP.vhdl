library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_NOP is
  port (
    EnterNOP: in  std_logic_vector(2 downto 0);
    SaidaNOP: out std_logic_vector(10 downto 0)
  );
end entity ; 

architecture archNOP of Mod_UC_NOP is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterNOP(2);
  b1            <= EnterNOP(1);
  b0            <= EnterNOP(0);

  SaidaNOP(10)  <= '1';                                   --barr/inc
  SaidaNOP(9)   <= '1';                                   --barr/PC
  SaidaNOP(8)   <= '0';                                   --ULA_op
  SaidaNOP(7)   <= '0';                                   --ULA_op
  SaidaNOP(6)   <= '0';                                   --ULA_op
  SaidaNOP(5)   <= (not(b2) and not(b1) and (b0));        --PC_rw
  SaidaNOP(4)   <= '0';                                   --AC_rw
  SaidaNOP(3)   <= '0';                                   --MEM_rw
  SaidaNOP(2)   <= (not(b2 and b1 and b0));               --REM_rw
  SaidaNOP(1)   <= (not(b2) and not(b1) and b0);          --RDM_rw
  SaidaNOP(0)   <= (not(b2) and b1 and not(b0));          --RI_rw
end architecture ;