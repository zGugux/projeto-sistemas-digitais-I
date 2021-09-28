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

architecture arc_fullAdderBCD of fullAdderBCD  is

    signal resultado, aux         : std_logic_vector ( 4 downto 0);

begin

    process (A,B,carryIn)

    begin
    
        resultado <= ( ('0' & A) + ( '0' & B)  + carryIn);

        if( resultado > 9) then

            aux <= resultado + "00110";
            C <= aux(3 downto 0);
            carryOut <= '1';

        else

            C <= resultado(3 downto 0);
            carryOut <= '0';

        end if;

    end process;

end arc_fullAdderBCD;