library ieee ;
    use ieee.std_logic_1164.all ;

entity LDA_ADD_AND_OR_NOT is
  port (
    EnterLda: in std_logic_vector(2 downto 0);
    EnterDecod: in std_logic_vector(10 downto 0);
    SaidaLda: out std_logic_vector(10 downto 0)
  );
end entity; 

architecture archLda of LDA_ADD_AND_OR_NOT is

begin
    SaidaLda(10) <=;    --barr/inc
    SaidaLda(9) <=;     --barr/PC
    SaidaLda(8) <=;     --ULA_op b2
    SaidaLda(7) <=;     --ULA_op b1
    SaidaLda(6) <=;     --ULA_op b0
    SaidaLda(5) <=;     --PC_rw
    SaidaLda(4) <=;     --AC_rw
    SaidaLda(3) <=;     --MEM_rw
    SaidaLda(2) <=;     --REM_rw
    SaidaLda(1) <=;     --RDM_rw
    SaidaLda(0) <=;     --RI_rw
end architecture ;