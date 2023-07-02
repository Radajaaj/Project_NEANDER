-- Testbench para Modulo ULA 
-- 2023 
-- Interfaces manipuladas: clk, rst, barramento, ula_op, AC_nrw e MEM_nrw
-- Interfaces observadas : flags_nz e barramento

----------------------------------------------------------------------------
-- IMPORTANTE: é necessário trocar o "component" para o SEU MODULO ULA!!!!!!
-- Linhas 33 e 56 <=========================================================
----------------------------------------------------------------------------

-- Teste executado: (em NEANDER adaptado)
-- tempo comando    regFlags_NZ (tempo)   barramento (tempo)
-- 00ns  RESET      01 (10ns e 30ns)      indiferente
-- 20ns  LDA 0x0F   00 (50ns)             indiferente
-- 40ns  OR  0x8A   10 (70ns)             indiferente
-- 60ns  AND 0x0A   00 (90ns)             indiferente
-- 80ns  NOT        10 (110ns)            indiferente
-- 100ns ADD 0x10   01 (130ns)            indiferente
-- 120ns STA        indiferente           0x00 (150ns)

-- se qualquer problema acontecer, no terminal será emitido uma mensagem de falha, por exemplo:
-- @(tempo):(assertion error): mensagem de erro

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_moduloULA is

end entity tb_moduloULA;

architecture quickmath of tb_moduloULA is
    constant cicloClock : time := 20 ns;

    -- ATENCAO: trocar para o SEU modulo ULA <==================================================
    -- pois os nomes e ordens das interfaces podem ser diferentes
    -- porém, a quantidade DEVE ser a mesma, senao, algo está errado
    component ULA_tudo is 
        port(
            interface_barramento : inout std_logic_vector(7 downto 0);
            mem_rw : in std_logic;
            AC_rw  : in std_logic;
            ULA_op : in std_logic_vector(2 downto 0);
            reset : in std_logic;
            clk    : in std_logic;
            interface_flags : out std_logic_vector(1 downto 0)
        );
        end component ULA_tudo;

    -- Nao é necessário alterar os sinais
    signal srst : std_logic := '0';
    signal sclk : std_logic := '0';
    signal sAC_nrw, sMEM_nrw : std_logic;
    signal sula_op     : std_logic_vector(2 downto 0);
    signal sflags_nz   : std_logic_vector(1 downto 0); -- [N,Z]
    signal sbarramento : std_logic_vector(7 downto 0);

begin
    -- ATENCAO: ordenar para o SEU modulo ULA <=================================================
    superula : ULA_tudo port map(
        sbarramento,
        sMEM_nrw,
        sAC_nrw,
        sula_op,
        srst,
        sclk,
        sflags_nz
     );

----------------------------------------------------------------------------
-- IMPORTANTE: não é necessário alterar nada à partir desta linha
----------------------------------------------------------------------------

    -- PROCESSO DE TESTE
    process
    begin
        -- aguarda reset concluir
        wait for cicloClock;        -- 20 ns
    
        -- simular leitura da memoria
        -- LDA valor 0x0F
            sula_op <= "000";     -- ula_op = 000 é LDA
            sbarramento <= x"0F"; -- valor no barramento
            sMEM_nrw <= '0';      -- memoria em leitura
            sAC_nrw <= '1';       -- gravar em AC
            wait for cicloClock;    -- 40 ns

            -- desligar sinais de gravacão
            sAC_nrw <= '0'; -- eu sei, mas desejei manter um padrão!
            
        -- OR valor 0x8A
            sula_op <= "010";     -- ula_op = 010 é OR
            sbarramento <= x"8A"; -- valor no barramento
            sMEM_nrw <= '0';      -- memoria em leitura
            sAC_nrw <= '1';       -- gravar em AC
            wait for cicloClock;    -- 60 ns
            
            -- desligar sinais de gravacão
            sAC_nrw <= '0';

        -- AND valor 0x0F
            sula_op <= "011";     -- ula_op = 011 é AND
            sbarramento <= x"0F"; -- valor no barramento
            sMEM_nrw <= '0';      -- memoria em leitura
            sAC_nrw <= '1';       -- gravar em AC
            wait for cicloClock;    -- 80 ns
            
            -- desligar sinais de gravacão
            sAC_nrw <= '0';

        -- NOT AC
            sula_op <= "100";     -- ula_op = 100 é NOT
            sbarramento <= x"0F"; -- valor no barramento é indiferente
            sMEM_nrw <= '0';      -- memoria em leitura
            sAC_nrw <= '1';       -- gravar em AC
            wait for cicloClock;    -- 100 ns
            
            -- desligar sinais de gravacão
            sAC_nrw <= '0';

        -- ADD valor 0x10
            sula_op <= "001";     -- ula_op = 001 é ADD
            sbarramento <= x"10"; -- valor no barramento para gerar zero
            sMEM_nrw <= '0';      -- memoria em leitura
            sAC_nrw <= '1';       -- gravar em AC
            wait for cicloClock;    -- 120 ns
            
            -- desligar sinais de gravacão
            sAC_nrw <= '0';


        -- CASO ESPECIAL
        -- STA
            sula_op <= "000";     -- ula_op é indiferente, padrão LDA
            sbarramento <= (others => 'Z'); -- valor no barramento DEVE SER "ZZZZZZZZ", senão gerará "XXXXXXXX"
            sMEM_nrw <= '1';      -- memoria em GRAVAcaO
            sAC_nrw <= '0';       -- AC em modo leitura
            wait for cicloClock;    -- 140 ns
            
            -- desligar sinais de gravacão
            sMEM_nrw <= '1';

        wait for cicloClock;

        wait;
    end process;

    -- PROCESSO DE VERIFICAcAO
    -- durante as subidas do clock
    process
    begin
        -- deslocar assert em 1/2 clock
        wait for cicloClock / 2;    -- 10 ns
        -- RESET é imediato
        -- vefiricar flags NZ (não é negativo, é zero)
        assert (sflags_nz = "01") report "Flags NZ incorretas (durante reset)" severity error;

        wait for cicloClock;        -- 30 ns (acumulado)

        -- RESET é imediato
        -- vefiricar flags NZ (não é negativo, é zero)
        assert (sflags_nz = "01") report "Flags NZ incorretas (apos reset)" severity error;

        wait for cicloClock;        -- 50 ns (acumulado)
        
        -- LDA valor 0x0F
        -- vefiricar flags NZ (não é negativo, nem zero)
        assert (sflags_nz = "00") 
            report "Flags NZ incorretas (durante LDA)"  
            severity error;

        wait for cicloClock;        -- 70 ns (acumulado)

        -- OR valor 0x8A
        -- vefiricar flags NZ (é negativo, não é zero)
        assert (sflags_nz = "10") 
            report "Flags NZ incorretas (durante OR)" 
            severity error;

        wait for cicloClock;        -- 90 ns (acumulado)

        -- AND valor 0x0F
        -- vefiricar flags NZ (não é negativo, nem é zero)
        assert (sflags_nz = "00") 
            report "Flags NZ incorretas (durante AND)" 
            severity error;

        wait for cicloClock;        -- 110 ns (acumulado)

        -- NOT
        -- vefiricar flags NZ (é negativo, não é zero)
        assert (sflags_nz = "10") 
            report "Flags NZ incorretas (durante NOT)" 
            severity error;
    
        wait for cicloClock;        -- 130 ns (acumulado)

        -- ADD
        -- vefiricar flags NZ (não é negativo, é zero)
        assert (sflags_nz = "01") 
            report "Flags NZ incorretas (durante ADD)" 
            severity error;

        wait for cicloClock;        -- 150 ns (acumulado)

        -- STA
        -- vefiricar flags NZ (não é negativo, é zero)
        assert (sflags_nz = "01" and sbarramento = x"00") 
            report "Flags NZ ou valor Bararmento incorreto (durante STA)" 
            severity error;

        wait;
    end process;


    -- o clock ainda pulsa!
    sclk <= not(sclk) after cicloClock / 2;

    -- processo para reset
    process
    begin
        -- reset inicial
        srst <= '0';
        wait for cicloClock;
        srst <= '1';
        wait;
    end process;

end architecture;
