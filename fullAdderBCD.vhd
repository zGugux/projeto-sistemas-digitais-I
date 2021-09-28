-- Arquivo que contém o fullAdder BCD

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fullAdderBCD is
    port (
        A,B  : in std_logic_vector( 3 downto 0); 
        carryIn  : in std_logic;
        C      : out std_logic_vector( 3 downto 0);
        carryOut : out std_logic
    );

end fullAdderBCD;

-- As entradas foram projetadas para receber dois números BCD. 
-- Sendo A e B a dezena e a unidade respectivamente do primeiro número
-- e C e D a dezena e a unidade respectivamente do segundo número.

architecture arc_fullAdderBCD of fullAdderBCD  is

    signal resultado         : std_logic_vector ( 3 downto 0);

begin

    process (A,B,carryIn)

    begin
    
        resultado <= (A + B + carryIn);

        if( resultado > 9) then

            C <= resultado + "0110";
            carryOut <= '1';

        else

            C <= resultado;
            carryOut <= '0';

        end if;
    end process;


end arc_fullAdderBCD;