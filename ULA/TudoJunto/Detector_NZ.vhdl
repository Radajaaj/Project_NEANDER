library ieee ;
use ieee.std_logic_1164.all ;

entity Detector_NZ is
  port (
    datain : in std_logic_vector(7 downto 0);
    FNZ : out std_logic_vector(1 downto 0)--N e Z
  );
end entity;
architecture hard of Detector_NZ is

begin

  FNZ (0)<= not(datain(7) or datain(6) or datain(5) or datain(4) or datain(3) or datain(2) or datain(1) or datain(0));
  FNZ (1)<= datain(7);

end architecture ;