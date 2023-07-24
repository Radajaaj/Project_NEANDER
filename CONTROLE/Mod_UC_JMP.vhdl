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

  SaidaJMP(10)  <= not(b2 and not(b1) and b0);                                    --barr/inc
  SaidaJMP(9)   <= '1';                                                           --barr/PC
  SaidaJMP(8)   <= '0';                                                           --ULA_op
  SaidaJMP(7)   <= '0';                                                           --ULA_op
  SaidaJMP(6)   <= '0';                                                           --ULA_op
  SaidaJMP(5)   <= (not(b1) and b0);                                              --PC_rw
  SaidaJMP(4)   <= '0';                                                           --AC_rw
  SaidaJMP(3)   <= '0';                                                           --MEM_rw
  SaidaJMP(2)   <= (not(b2) and not(b1) and not(b0)) or (not(b2) and b1 and b0);  --REM_rw
  SaidaJMP(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));  --RDM_rw
  SaidaJMP(0)   <= (not(b2) and b1 and not(b0));                                  --RI_rw
end architecture ;