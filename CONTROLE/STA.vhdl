library ieee ;
    use ieee.std_logic_1164.all ;

entity STA is
  port (
    EnterSta: in std_logic_vector(2 downto 0);
    SaidaSta: out std_logic_vector(10 downto 0)
  );
end entity ; 

architecture archSta of STA is

begin
    SaidaSta(10) <=;    --barr/inc
    SaidaSta(9) <=;     --barr/PC
    SaidaSta(8) <=;     --ULA_op b2
    SaidaSta(7) <=;     --ULA_op b1
    SaidaSta(6) <=;     --ULA_op b0
    SaidaSta(5) <=;     --PC_rw
    SaidaSta(4) <=;     --AC_rw
    SaidaSta(3) <=;     --MEM_rw
    SaidaSta(2) <=;     --REM_rw
    SaidaSta(1) <=;     --RDM_rw
    SaidaSta(0) <=;     --RI_rw
end architecture ;