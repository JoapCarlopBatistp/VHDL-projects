----------------------------------------------------------------------------------
--ALUNO: JOÃO CARLOS BATISTA
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity datapath_neander is
    Port (clk: in std_logic;                             --sinal de clock
          rst: in std_logic;                             --sinal de reset
          Negative: out std_logic;
          Zero: out std_logic;
          outputData: out std_logic_vector(7 downto 0)
    );
end datapath_neander;

architecture Behavioral of datapath_neander is
--Memória BRAM-----------------------------------------------
component memory
port(
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;
signal outputMem: std_logic_vector(7 downto 0);
signal writeMem: std_logic_vector(0 downto 0);
--Sinais do acumulador---------------------------------------
signal cargaACC: std_logic := '0';
signal inputACC: std_logic_vector(7 downto 0);
signal outputACC: std_logic_vector(7 downto 0);
--Sinais do REM----------------------------------------------
signal cargaREM: std_logic := '0';
signal inputREM: std_logic_vector(7 downto 0);
signal outputREM: std_logic_vector(7 downto 0);
--Sinais do PC-----------------------------------------------
signal incPC: std_logic := '0';
signal cargaPC: std_logic := '0';
signal inputPC: std_logic_vector(7 downto 0);
signal outputPC: std_logic_vector(7 downto 0);
--Sinais do RDM----------------------------------------------
signal cargaRDM: std_logic := '0';
signal inputRDM: std_logic_vector(7 downto 0);
signal outputRDM: std_logic_vector(7 downto 0);
--Sinais do RI-----------------------------------------------
signal cargaRI: std_logic := '0';
signal inputRI: std_logic_vector(3 downto 0);
signal outputRI: std_logic_vector(3 downto 0);
--ULA--------------------------------------------------------
signal selULA: std_logic_vector(2 downto 0);
signal input1: std_logic_vector(7 downto 0);
signal input2: std_logic_vector(7 downto 0);
signal registerULA: std_logic_vector(7 downto 0);
signal outputULA: std_logic_vector(7 downto 0);
--MUX1-------------------------------------------------------
signal selMUX1: std_logic := '0';
signal outputMUX1: std_logic_vector(7 downto 0);
--MUX2-------------------------------------------------------
signal selMUX2: std_logic := '0';
signal outputMUX2: std_logic_vector(7 downto 0);
--Negative/Zero----------------------------------------------
signal cargaNZ: std_logic := '0';
signal registerN: std_logic;
signal registerZ: std_logic;
signal outputN: std_logic;
signal outputZ: std_logic;
--Decodificador----------------------------------------------
signal decodificador: std_logic_vector(3 downto 0);
signal comandos: std_logic_vector(11 downto 0);
-------------------------------------------------------------
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
signal state, nextState: state_type;
-------------------------------------------------------------
begin
--Memória BRAM-----------------------------------------------
mem: memory
port map(
    clka => clk,
    wea => writeMem,
    addra => outputREM,
    dina => outputACC,
    douta => outputMem
);
--process do acumulador--------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            inputACC <= "00000000";
        elsif (clk'event and clk='1') then
            if(cargaACC='1') then
                inputACC <= outputULA;
            else
                inputACC <= inputACC;
            end if;
        end if;      
end process;
outputACC <= inputACC;
--process do REM---------------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            inputREM <= "00000000";
        elsif (clk'event and clk='1') then
            if(cargaREM='1') then
                inputREM <= outputMUX1;
            else
                inputREM <= inputREM;
            end if;
        end if;      
end process;
outputREM <= inputREM;
--process do PC----------------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            inputPC <= "00000000";
        elsif (clk'event and clk='1') then
            if(cargaPC='1') then
                inputPC <= outputMem;
            elsif(incPC='1') then
                inputPC <= inputPC + 1;
            else
                inputPC <= inputPC;
                
            end if;
        end if;      
end process;
outputPC <= inputPC;
--process do RDM----------------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            inputRDM <= "00000000";
        elsif (clk'event and clk='1') then
            if(cargaRDM='1') then
                inputRDM <= outputMUX2;
            else
                inputRDM <= inputRDM;
            end if;
        end if;      
end process;
outputRDM <= inputRDM;
--process do RI-----------------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            inputRI <= "0000";
        elsif (clk'event and clk='1') then
            if(cargaRI='1') then
                inputRI <= outputMem(7 downto 4);
            else
                inputRI <= inputRI;
            end if;
        end if;      
end process;
outputRI <= inputRI;
--process da ULA----------------------------------------------
input1 <= outputACC;
input2 <=outputMem;
process(selULA, input1, input2)
    begin
        case selULA is
            when "000" => registerULA <= (input1 + input2);   --soma
            when "001" => registerULA <= (input1 and input2); --and
            when "010" => registerULA <= (input1 or input2);  --or
            when "011" => registerULA <= (not input1);        --not
            when "100" => registerULA <= (input2);            --LDA
            when others => registerULA <= (input1);
        end case;     
end process;
outputULA <= registerULA;
--process do MUX1---------------------------------------------
process(selMUX1, outputPC, outputRDM)
    begin
        if(selMUX1='0') then
            outputMUX1 <= outputPC;
        else
            outputMUX1 <= outputRDM;
        end if;
end process;
--process do MUX2---------------------------------------------
process(selMUX2, outputACC, outputMem)
    begin
        if(selMUX2='0') then
            outputMUX2 <= outputACC;
        else
            outputMUX2 <= outputMem;
        end if;
end process;
--process do NZ-----------------------------------------------
process(clk, rst)
    begin
        if (rst = '1') then
            registerN <= '0';
            registerZ <= '0';
        elsif (clk'event and clk='1') then
            if(cargaNZ='1') then
                if(outputACC="00000000") then
                    registerZ <= '1';
                else
                    registerZ <= '0';
                end if;
                registerN <= outputACC(7);
            end if;
        end if;   
end process;
outputZ <= registerZ;
outputN <= registerN;
--process do decod--------------------------------------------
decodificador <= outputRI(3 downto 0);
process(decodificador)
    begin
        comandos <= "000000000000";
        case decodificador is
            when "0000" => comandos(0) <= '1';  --NOP
            when "0001" => comandos(1) <= '1';  --STA
            when "0010" => comandos(2) <= '1';  --LDA
            when "0011" => comandos(3) <= '1';  --ADD
            when "0100" => comandos(4) <= '1';  --OR
            when "0101" => comandos(5) <= '1';  --AND
            when "0111" => comandos(6) <= '1';  --NOT
            when "1000" => comandos(8) <= '1';  --JMP
            when "1001" => comandos(9) <= '1';  --JN
            when "1010" => comandos(10) <= '1'; --JZ
            when "1011" => comandos(11) <= '1'; --HLT
            when others => comandos <= "000000000000";
        end case;
end process;

process(clk, rst)
    begin
        if rst = '1' then
        state <= S0;
    elsif(clk'event and clk='1') then
        state <= nextState;
    end if;
end process;

process(comandos, state, nextState)
    begin
        case state is
            when s0 =>
                cargaREM <= '1';
                nextState <= s1;
                
            when s1 =>
                cargaREM <= '0';
                incPC <= '1';
                nextstate <= s2;
                
            when s2 =>
                incPC <= '0';
                cargaRI <= '1';
                nextstate <= s3;
            
            when s3 =>
                cargaRI <= '0';
                if (comandos(6)='1') then
                    selULA <= "011";
                    cargaACC <= '1';
                    cargaNZ <= '1';
                    nextState <= s0;
                end if;
                if (comandos(9)='1' and outputN = '0') then
                    incPC <= '1';
                    nextState <= s0;
                end if;
                if (comandos(10)='1' and outputZ = '0') then
                    incPC <= '1';
                    nextState <= s0;
                end if;
                if (comandos(0) ='1') then
                    nextState <= s0;
                end if;
                if (comandos(11) ='1') then
                    nextState <= s8;
                end if;
                
                cargaREM <= '1';                            --pode dar problema no futuro, verificar no teste

                nextstate <= s4;
                
            when s4 =>
                cargaACC <= '0';
                cargaNZ <= '0';
                incPC <= '0';
                if(comandos(1) = '1' or comandos(2) = '1' or comandos(3) = '1' or comandos(4) = '1' or comandos(5) = '1') then
                    incPC <= '1';
                end if;
                nextstate <= s5;
                
            when s5 =>
                incPC <= '0';
                if(comandos(1) = '1' or comandos(2) = '1' or comandos(3) = '1' or comandos(4) = '1' or comandos(5) = '1') then
                    selMUX <= '1';
                    cargaREM <= '1';
                end if;
                if(comandos(8) = '1' or comandos(9) = '1' or comandos(10) = '1') then
                    incPC <= '1';
                    nextState <= s0;
                end if;
                nextstate <= s6;
                
            when s6 =>
                incPC <= '0';
                selMUX <= '0';
                cargaREM <= '0';
                nextstate <= s7;
            
            when s7 =>
                if(comando(1) = '1') then
                    writeMem <= '1';
                end if;
                if(comando(2) = '1') then
                    selULA <= "100";
                    cargaACC <= '1';
                    cargaNZ <= '1';
                end if;
                if(comando(3) = '1') then
                    selULA <= "000";
                    cargaACC <= '1';
                    cargaNZ <= '1';
                end if;
                if(comando(4) = '1') then
                    selULA <= "010";
                    cargaACC <= '1';
                    cargaNZ <= '1';
                end if;
                if(comando(5) = '1') then
                    selULA <= "001";
                    cargaACC <= '1';
                    cargaNZ <= '1';
                end if;
                nextState <= s0;
            
            when s8 =>
                nextState <= s8;

        end case;
end process;
end Behavioral;