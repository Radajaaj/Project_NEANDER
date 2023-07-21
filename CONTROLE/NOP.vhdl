library ieee ;
    use ieee.std_logic_1164.all ;

entity NOP is
  port (
    EnterNop: in std_logic_vector(2 downto 0);
    SaidaNop: out std_logic_vector(10 downto 0)
  );
end entity ; 

architecture archNop of NOP is

begin
    SaidaNop(10) <=;    --barr/inc
    SaidaNop(9) <=;     --barr/PC
    SaidaNop(8) <=;     --ULA_op b2
    SaidaNop(7) <=;     --ULA_op b1
    SaidaNop(6) <=;     --ULA_op b0
    SaidaNop(5) <=;     --PC_rw
    SaidaNop(4) <=;     --AC_rw
    SaidaNop(3) <=;     --MEM_rw
    SaidaNop(2) <=;     --REM_rw
    SaidaNop(1) <=;     --RDM_rw
    SaidaNop(0) <=;     --RI_rw
end architecture ;