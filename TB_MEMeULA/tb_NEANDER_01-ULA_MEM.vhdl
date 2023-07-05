-- Testbench para Módulo ULA 
-- 2023 
-- Interfaces manipuladas: clk, rst, barramento, ula_op, AC_nrw e MEM_nrw
-- Interfaces observadas : flags_nz e barramento

----------------------------------------------------------------------------
-- IMPORTANTE: é necessário trocar o "component" para o SEU MDULO ULA e MDULO MEM!!!!!!
-- Linhas 36 e 50 <=========================================================
-- Linhas 75 e 85 <=========================================================
----------------------------------------------------------------------------

-- ghdl -r tb_moduloULAMEM --stop-time=550ns --wave=tb_moduloULAMEM.ghw

-- Teste executado: 
-- tempo comando    barramento (tempo)
-- 00ns  RESET      0x00 (10ns)         ignorar o (assertion warning): NUMERIC_STD.TO_INTEGER em 0ns
-- Muitas coisas acontecerão aqui e não serão listadas
-- se a saída conter apenas o assertion warning listado acima 
--      abra sua memória no endereço 132 e procure uma mudança de valor de 0 para 02 no tempo 420 ns

-- se qualquer problema acontecer, no terminal será emitido uma mensagem de falha, por exemplo:
-- @(tempo):(assertion error): mensagem de erro

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_moduloULAMEM is
end entity tb_moduloULAMEM;

architecture quickmath of tb_moduloULAMEM is
    constant cicloClock : time := 20 ns;

    -- ATENcaO: trocar para o SEU módulo ULA <==================================================
    -- pois os nomes e ordens das interfaces podem ser diferentes
    -- porém, a quantidade DEVE ser a mesma, senão, algo está errado

    component ULA_tud is 
        port(
            interface_barramento : inout std_logic_vector(7 downto 0);
            mem_rw : in std_logic;
            AC_rw  : in std_logic;
            ULA_op : in std_logic_vector(2 downto 0);
            reset : in std_logic;
            clk    : in std_logic;
            interface_flags : out std_logic_vector(1 downto 0)
        );
    end component;

    -- ATENcaO: trocar para o SEU módulo MEM <==================================================
    -- pois os nomes e ordens das interfaces podem ser diferentes
    -- porém, a quantidade DEVE ser a mesma, senão, algo está errado

    component modulo_Mem is port
        (
            end_PC   : in std_logic_vector(7 downto 0);
            end_Barr : in std_logic_vector(7 downto 0);
            nBarrPC  : in std_logic;
            REM_rw   : in std_logic;
            MEM_rw   : in std_logic;
            RDM_rw   : in std_logic;
            reset    : in std_logic;
            clk      : in std_logic;
            interface_barramento : inout std_logic_vector(7 downto 0)
        );
    end component;

    -- Não é necessário alterar os sinais
    signal srst : std_logic := '1';
    signal sclk : std_logic := '0';
    signal sAC_nrw, sMEM_nrw : std_logic := '0';
    signal sula_op     : std_logic_vector(2 downto 0) := (others => '0'); -- inicia em LDA
    signal sflags_nz   : std_logic_vector(1 downto 0); -- [N,Z]
    signal sbarramento : std_logic_vector(7 downto 0) := (others => '0'); -- para evitar warning assert em 0ns;

    signal snbarrPC, sREM_nrw, sRDM_nrw : std_logic := '0';
    signal send_PC : std_logic_vector(7 downto 0);

begin
    -- ATENcaO: ordenar para o SEU módulo ULA <=================================================
    superula : ULA_tud port map(
        sbarramento,
        sMEM_nrw,
        sAC_nrw,
        sula_op,
        srst,
        sclk, 
        sflags_nz
     );

    -- ATENcaO: ordenar para o SEU módulo MEM <=================================================
    supermem : modulo_Mem port map(
        send_PC,        -- entrada via PC (RIP)
        sbarramento,    -- yep, entrada via barramento
        snbarrPC,       -- seletor do multiplexador PC ou Barramento
        sREM_nrw,       -- carga REM
        sMEM_nrw,       -- read = 0 ou write = 1 para memória (é o mesmo do mux especial da ULA)
        sRDM_nrw,       -- carga RDM
        srst, sclk, 
        sbarramento     -- é o barramento do sistema, o mesmo que inout da ULA
    );

----------------------------------------------------------------------------
-- IMPORTANTE: não é necessário alterar nada à partir desta linha
----------------------------------------------------------------------------

    -- PROCESSO DE TESTE
    process
    begin
        -- aguarda reset concluir
        wait for cicloClock;        -- 20 ns

        -- LDA 130
            -- passar do PC (zero) para o REM e configurar MEM em modo leitura
            send_PC <= x"00";
            snbarrPC <= '1';
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
    
            wait for cicloClock;   -- 40 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 60 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';

            -- barramento deve conter o valor do LDA (32) em 70 ns
            
        -- incrementar o PC e encontrar o endereço do operando do LDA (130)
            send_PC <= x"01";
            snbarrPC <= '1';   
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
            wait for cicloClock;   -- 80 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 100 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';

            -- barramento deve conter o valor do endereço do operando LDA (130) em 110 ns

        -- levar o endereço do operando novamente para REM 
            -- configurar multiplexador para pegar barramento
            snbarrPC <= '0';
            
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
    
            wait for cicloClock;   -- 120 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 140 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';
            
        -- carregar no AC para depois realizar um ADD
            -- ula_op já deve estar em zero, mas ... não custa reforçar!
            sula_op <= "000"; -- that's an LDA!!!
            -- carregar AC
            sAC_nrw <= '1';
            wait for cicloClock;    -- 160 ns
            -- desligar o carga AC            
            sAC_nrw <= '0';
        
            -- esperado flags N=1 e Z = 0 em 170 ns

        -- ADD 131
            -- incrementar PC e enviar para REM (valor x"02")
            send_PC <= x"02";
            snbarrPC <= '1';   
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
            wait for cicloClock;   -- 180 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 200 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';

            -- barramento deve conter o valor do ADD (48) em 210 ns

        -- incrementar o PC e encontrar o endereço do operando do ADD (131)
            send_PC <= x"03";
            snbarrPC <= '1';   
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
            wait for cicloClock;   -- 220 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 240 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';
    
-- levar o endereço do operando novamente para REM 
            -- configurar multiplexador para pegar barramento
            snbarrPC <= '0';
            
            -- carregar REM
            sREM_nrw <= '1';
            -- configurar MEM em leitura
            sMEM_nrw <= '0';
    
            wait for cicloClock;   -- 260 ns

            -- desligar carga de REM
            sREM_nrw <= '0';
            -- carregar RDM após memória responder
            sRDM_nrw <= '1';
            
            wait for cicloClock;    -- 280 ns
            -- desligar carga RDM
            sRDM_nrw <= '0';
            
        -- ADD no AC 
            -- ula_op deve ser alterada para ADD
            sula_op <= "001"; -- that's an ADD!!!
            -- carregar AC
            sAC_nrw <= '1';
            wait for cicloClock;    -- 300 ns
            -- desligar o carga AC            
            sAC_nrw <= '0';
        
            -- esperado flags N=0 e Z = 0 em 270 ns

        -- enviar resultado para Memória no endereço 132
        -- buscar o LDA 132 na memória end. 04 e 05 e depois usar o operando para escrever AC em mem
            send_PC <= x"04";
            snbarrPC <= '1';
            sREM_nrw <= '1';
            wait for cicloClock;    -- carga REM    320 ns
            sREM_nrw <= '0'; 
            snbarrPC <= '0';
            sRDM_nrw <= '1';
            wait for cicloClock;    -- carga RDM    340 ns
            -- neste ponto, deve aparecer 0x10 no barramento, código do STA (350 ns)
            sRDM_nrw <= '0';
            send_PC <= x"05";
            snbarrPC <= '1';
            sREM_nrw <= '1';
            wait for cicloClock;    -- carga REM com endereço do operando     360 ns
            sREM_nrw <= '0';
            snbarrPC <= '0'; 
            sRDM_nrw <= '1';
            wait for cicloClock;    -- carga RDM    380 ns
            -- neste ponto, deve aparecer 0x84 no barramento, operando do STA (390 ns)
            sRDM_nrw <= '0';

            -- escrita em memória
            sREM_nrw <= '1';
            wait for cicloClock;    -- 400 ns
            sREM_nrw <= '0';
            wait for cicloClock;    -- 420 ns
            sMEM_nrw <= '1';
            wait for cicloClock;    -- 440 ns
            sMEM_nrw <= '0';
            

        wait for cicloClock;

        wait;
    end process;

    -- PROCESSO DE VERIFICAcaO
    -- durante as subidas do clock
    process
    begin
        -- deslocar assert em 1/2 clock
        wait for cicloClock / 2;    -- 10 ns
        -- RESET é imediato
        
        -- verificar barramento como zero!
        assert (sbarramento = x"00") 
            report "Barramento não é zero em estado inicial RESET"
            severity error;

        assert (sflags_nz = "01") 
            report "Flags NZ com problemas em estado inicial RESET (esperado N=0 e Z=1)"
            severity error;

        -- vefiricar barramento em LDA (48) em 70 ns
        wait for cicloClock * 3;
        assert (sbarramento = x"20") 
            report "Barramento falhou em LDA (32)"
            severity error;

        -- vefiricar barramento em LDA (130) em 110 ns
        wait for cicloClock * 2;
        assert (sbarramento = x"82") 
            report "Barramento falhou em operando LDA (130)"
            severity error;

        -- vefiricar barramento em LDA 130, esperado o valor -1 em 150 ns
        wait for cicloClock * 2;
        assert (sbarramento = x"FF") 
            report "Barramento falhou em operando LDA 130 (-1 ou 0xFF)"
            severity error;
    
        wait for cicloClock;

        -- verificar flags_nz em carga AC em 170 ns
        assert (sflags_nz = "10") 
            report "Flags NZ com problemas em carga AC (esperado N=1 e Z=0)"
            severity error;
   
        wait for cicloClock * 2;    -- 210 ns

        -- verificar barramento em ADD (48)
        assert (sbarramento = x"30") 
            report "Barramento falhou em operando ADD (0x30)"
            severity error;        

        wait for cicloClock * 2; -- 250 ns

        -- verificar barramento em operando ADD (130)
        assert (sbarramento = x"83") 
            report "Barramento falhou em operando ADD 130 (0x82)"
            severity error; 
    
        wait for cicloClock * 3; -- 310 ns

        -- verificar flags_nz em ADD em 310 ns
        assert (sflags_nz = "00") 
            report "Flags NZ com problemas em carga AC (esperado N=0 e Z=0)"
            severity error;

        -- Se até aqui funcionou, muitas partes estão boas!
        -- testando somente o STA
        wait for cicloClock * 6; -- 430 ns
        assert (sbarramento = x"02") 
            report "Barramento falhou em operando STA 16 (esperado 0x02)"
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
