library ieee ;
use ieee.std_logic_1164.all ;

entity tb_detector is 
end tb_detector; 

architecture arch of tb_detector is
  component Detector_NZ is
    port (
      datain : in std_logic_vector(7 downto 0);
      FNZ : out std_logic_vector(1 downto 0)--N e Z
    );
  end component;

    signal s_datain: std_logic_vector(7 downto 0);
    signal s_FNZ :std_logic_vector(1 downto 0);
    
begin

    u_detec : Detector_NZ port map (s_datain, s_FNZ );

    tbp : process
    begin

    s_datain <= "01010101"; 
    wait for 20 ns;

    s_datain <= "11010101"; 
    wait for 20 ns;

    s_datain <= "11010000"; 
    wait for 20 ns;

    s_datain <= "01010101"; 
    wait for 20 ns;

    s_datain <= "11011101"; 
    wait for 20 ns;
    wait for 20 ns;

    end process;

end architecture ;