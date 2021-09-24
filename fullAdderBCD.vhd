-- Arquivo que contém o fullAdder BCD

library ieee;
use ieee.std_logic_1164.ALL;

entity fullAdderBCD2 is

    port (
        A,B,C,D  : in std_logic_vector( 3 downto 0); --entradas em BCD. DU e DU
        carryIn  : in std_logic;
        E,F      : out std_logic_vector( 3 downto 0);
        carryOut : out std_logic
    );

end fullAdderBCD2;

-- As entradas foram projetadas para receber dois números BCD. 
-- Sendo A e B a dezena e a unidade respectivamente do primeiro número
-- e C e D a dezena e a unidade respectivamente do segundo número.

architecture arc_fullAdderBCD of fullAdderBCD2  is

	component fullADDER4bits
    port ( A,B: in std_logic_vector (3 downto 0);
             Cin: in std_logic;
             S: out std_logic_vector (3 downto 0);
             Cout: out std_logic
        );
    end component;

    component fatorCorrecao
    port ( dezena, unidade: in std_logic_vector (3 downto 0);
             carryIn: in std_logic;
             E,F : out std_logic_vector (3 downto 0);
             carryOut: out std_logic
        );
    end component;

    signal carry_unidade, carry_dezena, carry_out : std_logic;
--    signal verificacao_unidade, verificacao_dezena: std_logic;
    signal saida1: std_logic_vector ( 3 downto 0);
    signal saida2: std_logic_vector ( 3 downto 0);
--    signal aux: std_logic_vector( 3 downto 0);

    begin

    carry_unidade <= carryIn;

    sum_unidade: fullADDER4bits port map(B, D, carry_unidade, saida1, carry_dezena);

    sum_dezena: fullADDER4bits port map(A, C, carry_dezena, saida2, carry_out);

    --fator de correção 

    fator_correcao: fatorCorrecao port map(saida2, saida1, carry_out, E, F, carryOut);

    

end arc_fullAdderBCD;