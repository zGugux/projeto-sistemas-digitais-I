library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fullAdderBCD_4algarismos is
    port (
        A,B  : in std_logic_vector( 15 downto 0); 
        carryIn : in std_logic;
        C      : out std_logic_vector( 19 downto 0)
    );

end fullAdderBCD_4algarismos;

architecture arc of fullAdderBCD_4algarismos is

    signal carry : std_logic_vector ( 2 downto 0);
    signal X,Y : std_logic_vector (15 downto 0 );
    signal Z: std_logic_vector (19 downto 0);

    component fullAdderBCD
        port (
            A,B  : in std_logic_vector( 3 downto 0); 
            carryIn  : in std_logic;
            C      : out std_logic_vector( 3 downto 0);
            carryOut : out std_logic
        );

    end component;

    begin
        
        X <= A;
        Y <= B;

        soma1: fullAdderBCD port map ( X(3 downto 0), Y(3 downto 0), carryIn, Z( 3 downto 0), carry(0));
        soma2: fullAdderBCD port map ( X(7 downto 4), Y(7 downto 4), carry(0), Z( 7 downto 4), carry(1));
        soma3: fullAdderBCD port map ( X(11 downto 8), Y(11 downto 8), carry(1), Z( 11 downto 08), carry(2));
        soma4: fullAdderBCD port map ( X(15 downto 12), Y(15 downto 12), carry(2), Z( 15 downto 12), Z(16));

        C <= Z;
         
end arc;
