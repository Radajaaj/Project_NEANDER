library ieee;
use ieee.std_logic_1164.all; -- std_logic para detectar erros
 
entity FJK is
    port(
        j, k   : in std_logic;
        clk    : in std_logic;
        pr, cl : in std_logic;
        q, nq  : out std_logic
    );
end entity;

architecture latc of FJK is
    signal sq  : std_logic := '0'; -- opcional -> valor inicial
    signal snq : std_logic := '1';
begin

    q  <= sq;
    nq <= snq;

    u_ff : process (clk, pr, cl)
    begin
        -- pr = 0 e cl = 0 -> Desconhecido
        if (pr = '0') and (cl = '0') then
            sq  <= 'X';
            snq <= 'X';
            -- prioridade para cl
            elsif (pr = '1') and (cl = '0') then
                sq  <= '0';
                snq <= '1';
                -- tratamento de pr
                elsif (pr = '0') and (cl = '1') then
                    sq  <= '1';
                    snq <= '0';
                    -- pr e cl desativados
                    elsif (pr = '1') and (cl = '1') then
                        if falling_edge(clk) then
                            -- jk = 00 -> mantém estado
                            if    (j = '0') and (k = '0') then
                                sq  <= sq;
                                snq <= snq;
                            -- jk = 01 -> q = 0
                            elsif (j = '0') and (k = '1') then
                                sq  <= '0';
                                snq <= '1';
                            -- jk = 01 -> q = 1
                            elsif (j = '1') and (k = '0') then
                                sq  <= '1';
                                snq <= '0';
                            -- jk = 11 -> q = !q
                            elsif (j = '1') and (k = '1') then
                                sq  <= not(sq);
                                snq <= not(snq);
                            -- jk = ?? -> falha
                            else
                                sq  <= 'U';
                                snq <= 'U';
                            end if;
                        end if;
            else
                sq  <= 'X';
                snq <= 'X';
        end if;
    end process;

end architecture;