library ieee ;
    use ieee.std_logic_1164.all ;

entity Mod_UC_JMP is
  port (
    EnterJMP    : in  std_logic_vector(2 downto 0);
    SaidaJMP    : out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archJMP of Mod_UC_JMP is

signal b2, b1, b0 : std_logic;

begin
  b2            <= EnterJMP(2);
  b1            <= EnterJMP(1);
  b0            <= EnterJMP(0);

  SaidaLda(10)  <= not(b2 and not(b1) and b0);                                    --barr/inc
  SaidaLda(9)   <= '1';                                                           --barr/PC
  SaidaLda(8)   <= '0';                                                           --ULA_op
  SaidaLda(7)   <= '0';                                                           --ULA_op
  SaidaLda(6)   <= '0';                                                           --ULA_op
  SaidaLda(5)   <= (not(b1) and b0);                                              --PC_rw
  SaidaLda(4)   <= '0';                                                           --AC_rw
  SaidaLda(3)   <= '0';                                                           --MEM_rw
  SaidaLda(2)   <= (not(b2) and not(b1) and not(b0)) or (not(b2) and b1 and b0);  --REM_rw
  SaidaLda(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));  --RDM_rw
  SaidaLda(0)   <= (not(b2) and b1 and not(b0));                                  --RI_rw
end architecture ;