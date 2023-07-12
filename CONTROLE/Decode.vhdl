library IEEE;
use IEEE.std_logic_1164.all;

entity decodificador is port
(
    instrin  : in  std_logic_vector(7 downto 0);
    instrout : out std_logic_vector(10 downto 0)
);
end decodificador;

architecture jorge of decodificador is 
begin
    
   instrout <=  "10000000000" when instrin = "00000000" else -- snop (nenhuma operacao)
                "01000000000" when instrin = "00010000" else -- ssta (armazena acumulador - store)
                "00100000000" when instrin = "00100000" else -- slda (carrega acumulador  - load)
                "00010000000" when instrin = "00110000" else -- sadd (soma)
                "00001000000" when instrin = "01000000" else -- sor  ("ou" logico)
                "00000100000" when instrin = "01010000" else -- sand ("e" logico)
                "00000010000" when instrin = "01100000" else -- snot (inverte (complementa) acumulador)
                "00000001000" when instrin = "10000000" else -- sjmp (desvio incondicional - jump)
                "00000000100" when instrin = "10010000" else -- sjn  (desvio condicional   - jump on negative)
                "00000000010" when instrin = "10100000" else -- sjz  (desvio condicional   - jump on zero)
                "00000000001" when instrin = "11110000";     -- shlt (termino de execucao  - halt)
end jorge;