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
  SaidaHLT(10)  <= '0';--barr/inc
  SaidaHLT(9)   <= '0';--barr/PC
  SaidaHLT(8)   <= '0';--ULA_op
  SaidaHLT(7)   <= '0';--ULA_op
  SaidaHLT(6)   <= '0';--ULA_op
  SaidaHLT(5)   <= '0';--PC_rw
  SaidaHLT(4)   <= '0';--AC_rw
  SaidaHLT(3)   <= '0';--MEM_rw
  SaidaHLT(2)   <= '0';--REM_rw
  SaidaHLT(1)   <= '0';--RDM_rw
  SaidaHLT(0)   <= '0';--RI_rw
end architecture ;