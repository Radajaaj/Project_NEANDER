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

  SaidaNop(10)  <= '1';                                   --barr/inc
  SaidaNop(9)   <= '1';                                   --barr/PC
  SaidaNop(8)   <= '0';                                   --ULA_op
  SaidaNop(7)   <= '0';                                   --ULA_op
  SaidaNop(6)   <= '0';                                   --ULA_op
  SaidaNop(5)   <= (not(b2) and not(b1) and (b0));        --PC_rw
  SaidaNop(4)   <= '0';                                   --AC_rw
  SaidaNop(3)   <= '0';                                   --MEM_rw
  SaidaNop(2)   <= (not(b2 and b1 and b0));               --REM_rw
  SaidaNop(1)   <= (not(b2) and not(b1) and b0);          --RDM_rw
  SaidaNop(0)   <= (not(b2) and b1 and not(b0));          --RI_rw
end architecture ;