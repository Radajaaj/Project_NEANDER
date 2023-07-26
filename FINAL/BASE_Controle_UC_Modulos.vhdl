--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- NOP --===--====-------====--===--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


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
  SaidaNOP(2)   <= (not(b2) and not(b1) and not(b0));     --REM_rw
  SaidaNOP(1)   <= (not(b2) and not(b1) and b0);          --RDM_rw
  SaidaNOP(0)   <= (not(b2) and b1 and not(b0));          --RI_rw
end architecture ;



--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- STA --===--====-------====--===--

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

  SaidaSTA(10)  <= '1';                                                                                         --barr/inc
  SaidaSTA(9)   <= (not(b2 and not(b1) and b0));                                                                --barr/PC
  SaidaSTA(8)   <= '0';                                                                                         --ULA_op
  SaidaSTA(7)   <= '0';                                                                                         --ULA_op
  SaidaSTA(6)   <= '0';                                                                                         --ULA_op
  SaidaSTA(5)   <= ((not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0)));                              --PC_rw
  SaidaSTA(4)   <= '0';                                                                                         --AC_rw
  SaidaSTA(3)   <= (b2 and b1 and not(b0));                                                                     --MEM_rw
  SaidaSTA(2)   <= (not(b2) and not(b1) and not(b0)) or (not(b2) and b1 and b0) or (b2 and not(b1) and b0);     --REM_rw
  SaidaSTA(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));                                --RDM_rw
  SaidaSTA(0)   <= (not(b2) and b1 and not(b0));                                                                --RI_rw
end architecture ;




--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- LDA --===--====-------====--===--
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

  SaidaLDA(10)  <= '1';                                                                                       --barr/inc
  SaidaLDA(9)   <= not(b2 and not(b1) and b0);                                                                --barr/PC
  SaidaLDA(8)   <= '0';                                                                                       --ULA_op
  SaidaLDA(7)   <= '1' when EnterDecod = "00001000000" else '1' when EnterDecod = "00000100000" else '0';     --ULA_op
  SaidaLDA(6)   <= '1' when EnterDecod = "00010000000" else '1' when EnterDecod = "00000100000" else '0';     --ULA_op
  SaidaLDA(5)   <= (not(b2) and not(b1) and b0) or (b2 and not(b1) and not(b0));                              --PC_rw
  SaidaLDA(4)   <= (b2 and b1 and b0);                                                                        --AC_rw
  SaidaLDA(3)   <= '0';                                                                                       --MEM_rw
  SaidaLDA(2)   <= (not(b2) and not(b1) and not(b0)) or (not(b2) and b1 and b0) or (b2 and not(b1) and b0);       --REM_rw
  SaidaLDA(1)   <= (not(b2) and not(b1) and b0) or (b2 and not(b0));                                          --RDM_rw
  SaidaLDA(0)   <= (not(b2) and b1 and not(b0));                                                              --RI_rw
end architecture ;


 

--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- NOT --===--====-------====--===--

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

  SaidaNOT(10)  <= '1';                                     --barr/inc
  SaidaNOT(9)   <= '1';                                     --barr/PC
  SaidaNOT(8)   <= '1';                                     --ULA_op
  SaidaNOT(7)   <= '0';                                     --ULA_op
  SaidaNOT(6)   <= '0';                                     --ULA_op
  SaidaNOT(5)   <= (not(b2) and not(b1) and b0);            --PC_rw
  SaidaNOT(4)   <= (b2 and b1 and b0);                      --AC_rw
  SaidaNOT(3)   <= '0';                                     --MEM_rw
  SaidaNOT(2)   <= (not(b2) and not(b1) and not(b0));       --REM_rw
  SaidaNOT(1)   <= (not(b2) and not(b1) and b0);            --RDM_rw
  SaidaNOT(0)   <= (not(b2) and b1 and not(b0));            --RI_rw
end architecture ;




--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- JMP --===--====-------====--===--

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




--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===- JMPNZ -===--====-------====--===--

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
  SaidaJMPNZ(2)   <= (not(b2) and not(b1) and not(b0));     --REM_rw
  SaidaJMPNZ(1)   <= (not(b2) and not(b1) and b0);          --RDM_rw
  SaidaJMPNZ(0)   <= (not(b2) and b1 and not(b0));          --RI_rw
end architecture;




--===--====-------====--===--=====--===--====-------====--===--
--===--====-------====--===-- HLT --===--====-------====--===--

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