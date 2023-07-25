library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_JMPNZ is
  port (
    EnterJMPNZ    : in  std_logic_vector(2 downto 0);
    SaidaJMPNZ    : out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archJMPNZ of Mod_UC_JMPNZ is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterJMPNZ(2);
  b1            <= EnterJMPNZ(1);
  b0            <= EnterJMPNZ(0);

  SaidaJMPNZ(10)  <= '1';                                   --barr/inc
  SaidaJMPNZ(9)   <= '1';                                   --barr/PC
  SaidaJMPNZ(8)   <= '0';                                   --ULA_op
  SaidaJMPNZ(7)   <= '0';                                   --ULA_op
  SaidaJMPNZ(6)   <= '0';                                   --ULA_op
  SaidaJMPNZ(5)   <= (not(b2) and (b0));                    --PC_rw
  SaidaJMPNZ(4)   <= '0';                                   --AC_rw
  SaidaJMPNZ(3)   <= '0';                                   --MEM_rw
  SaidaJMPNZ(2)   <= (not(b2 and b1 and b0));               --REM_rw
  SaidaJMPNZ(1)   <= (not(b2) and not(b1) and b0);          --RDM_rw
  SaidaJMPNZ(0)   <= (not(b2) and b1 and not(b0));          --RI_rw
end architecture ;