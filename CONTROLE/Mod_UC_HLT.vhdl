library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_HLT is
  port (
    EnterHLT    : in  std_logic_vector(2 downto 0);
    SaidaHLT    : out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archHLT of Mod_UC_HLT is

begin
  SaidaLda(10)  <= '0';--barr/inc
  SaidaLda(9)   <= '0';--barr/PC
  SaidaLda(8)   <= '0';--ULA_op
  SaidaLda(7)   <= '0';--ULA_op
  SaidaLda(6)   <= '0';--ULA_op
  SaidaLda(5)   <= '0';--PC_rw
  SaidaLda(4)   <= '0';--AC_rw
  SaidaLda(3)   <= '0';--MEM_rw
  SaidaLda(2)   <= '0';--REM_rw
  SaidaLda(1)   <= '0';--RDM_rw
  SaidaLda(0)   <= '0';--RI_rw
end architecture ;