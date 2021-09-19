-- Arquivo que contém o fullAdder BCD

library ieee;
use ieee.std_logic_1164.ALL;

entity fullAdderBCD is

    port (
        A,B,C,D  : in std_logic_vector( 3 downto 0); --entradas em BCD. DU e DU
        carryIn  : in std_logic;
        E,F      : out std_logic_vector( 3 downto 0);
        carryOut : out std_logic
    );

end fullAdderBCD;

-- As entradas foram projetadas para receber dois números BCD. 
-- Sendo A e B a dezena e a unidade respectivamente do primeiro número
-- e C e D a dezena e a unidade respectivamente do segundo número.

architecture logica of fullAdderBCD  is

	component fullAdder
    port ( A,B: in std_logic;
             Cin: in std_logic;
             S: out std_logic;
             Cout: out std_logic);

    End component;

    signal carry: std_logic_vector ( 8 downto 0);
    signal verificacao_unidade, verificacao_dezena: std_logic;
    signal vetor1: std_logic_vector ( 3 downto 0);
    signal vetor2: std_logic_vector ( 3 downto 0);
    signal aux: std_logic_vector( 3 downto 0);


begin
    
    carry(0) <= carryIn;

    sum_unidade_0: fullAdder port map (B(0), D(0), carry(0), vetor1(0), carry(1));
	sum_unidade_1: fullAdder port map (B(1), D(1), carry(1), vetor1(1), carry(2));
	sum_unidade_2: fullAdder port map (B(2), D(2), carry(2), vetor1(2), carry(3));
	sum_unidade_3: fullAdder port map (B(3), D(3), carry(3), vetor1(3), carry(4));
    
    sum_dezena_0: fullAdder port map (A(0), C(0), carry(4), vetor2(0), carry(5));
    sum_dezena_1: fullAdder port map (A(1), C(1), carry(5), vetor2(1), carry(6));
    sum_dezena_2: fullAdder port map (A(2), C(2), carry(6), vetor2(2), carry(7));
    sum_dezena_3: fullAdder port map (A(3), C(3), carry(7), vetor2(3), carry(8));
    
    carryOut <= carry(8);

    -- fator de correção

    correcao_process: process (verificacao_unidade, verificacao_dezena, vetor1, vetor2, aux)

    begin

        verificacao_unidade <= (vetor1(3) and ( vetor1(2) or vetor1(1)));
        verificacao_dezena <=  (vetor2(3) and ( vetor2(2) or vetor2(1)));

        E(0) <= vetor1(0);
        E(1) <= vetor1(1);
        E(2) <= vetor1(2);
        E(3) <= vetor1(3);
        
        F(0) <= vetor2(0);
        F(1) <= vetor2(1);
        F(2) <= vetor2(2);
        F(3) <= vetor2(3);    


        if ((verificacao_unidade = '1') and (verificacao_dezena = '0'))  then

            F(3) <= '0';
            F(2) <= (vetor1(3) and vetor1(2) and vetor1(1));
            F(1) <= (vetor1(3) and vetor1(2) and (not vetor1(1)));
            F(0) <= ((vetor1(3) and vetor1(2)) and ( vetor1(1) or vetor1(0)));

            aux(3) <= (((not vetor2(3)) and (vetor2(1) or vetor2(0))) or  ((vetor2(3) xor vetor2(2)) and (vetor2(1) and vetor2(0))));
            aux(2) <= (((not vetor2(3)) and vetor2(1) and vetor2(0)) or (vetor2(2) and ((not vetor2(1)) or ( vetor2(1) and (not vetor2(0) ) ))));
            aux(1) <= vetor2(1) xor vetor2(0);
            aux(0) <= not vetor2(0);

            verificacao_dezena <= (aux(3) and ( aux(2) or aux(1)));
            verificacao_unidade <= '0';
            
            vetor2(3) <= aux(3);
            vetor2(2) <= aux(2);
            vetor2(1) <= aux(1);
            vetor2(0) <= aux(0);

            if( verificacao_dezena = '0') then

                E(0) <= vetor1(0);
                E(1) <= vetor1(1);
                E(2) <= vetor1(2);
                E(3) <= vetor1(3);

            end if;
        end if;

        if ((verificacao_unidade = '1') and (verificacao_dezena = '1' )) then

            F(3) <= '0';
            F(2) <= (vetor1(3) and vetor1(2) and vetor1(1));
            F(1) <= (vetor1(3) and vetor1(2) and (not vetor1(1)));
            F(0) <= ((vetor1(3) and vetor1(2)) and ( vetor1(1) or vetor1(0)));

            E(3) <= (((not vetor2(3)) and (vetor2(1) or vetor2(0))) or  ((vetor2(3) xor vetor2(2)) and (vetor2(1) and vetor2(0))));
            E(2) <= (((not vetor2(3)) and vetor2(1) and vetor2(0)) or (vetor2(2) and ((not vetor2(1)) or ( vetor2(1) and (not vetor2(0) ) ))));
            E(1) <= vetor2(1) xor vetor2(0);
            E(0) <= not vetor2(0);

            E(3) <= '0';
            E(2) <= (vetor2(3) and vetor2(2) and vetor2(1));
            E(1) <= (vetor2(3) and vetor2(2) and (not vetor2(1)));
            E(0) <= ((vetor2(3) and vetor2(2)) and ( vetor2(1) or vetor2(0)));

            verificacao_dezena <= '0';
            verificacao_unidade <= '0';
        
        end if;

        if ((verificacao_dezena = '1') and (verificacao_unidade = '0')) then

            E(3) <= '0';
            E(2) <= (vetor1(3) and vetor1(2) and vetor1(1));
            E(1) <= (vetor1(3) and vetor1(2) and (not vetor2(1)));
            E(0) <= ((vetor2(3) and vetor2(2)) and ( vetor2(1) or vetor2(0)));

            verificacao_dezena <= '0';
            verificacao_unidade <= '0';

        end if;

    end process;

end logica;