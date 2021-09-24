library ieee;
use ieee.std_logic_1164.ALL;

entity fatorCorrecao is

    port (
        dezena , unidade  : in std_logic_vector( 3 downto 0); 
        carryIn  : in std_logic;
        E,F      : out std_logic_vector( 3 downto 0);
        carryOut : out std_logic
    );

end fatorCorrecao;


architecture arc_fatorCorrecao of fatorCorrecao is

    signal verificacao_unidade, verificacao_dezena: std_logic;
    signal aux: std_logic_vector( 3 downto 0);

    begin

        fator_correcao: process (verificacao_unidade, verificacao_dezena, unidade, dezena, aux)

        begin
    
            verificacao_unidade <=  (unidade(3) and ( unidade(2) or unidade(1)));
            verificacao_dezena <=  (dezena(3) and ( dezena(2) or dezena(1)));

            
            if ((verificacao_unidade = '1') and (verificacao_dezena = '0'))  then

                -- soma 6
    
                F(3) <= '0';
                F(2) <=  (unidade(3) and unidade(2) and unidade(1));
                F(1) <=  (unidade(3) and unidade(2) and (not unidade(1)));
                F(0) <= ((unidade(3) and unidade(2)) and ( unidade(1) or unidade(0)));

                --soma 1
    
                aux(3) <= ( ((not dezena(3)) and  (dezena(1) or dezena(0))) or  ( (dezena(3) xor dezena(2)) and  dezena(1) and dezena(0)) );
                aux(2) <= ( ( (not dezena(2)) and dezena(1) and dezena(0)) or (dezena(2) and ( (not dezena(1)) or (dezena(1) and (not dezena(0)) ) ) )); 
                aux(1) <= dezena(1) xor dezena(0);
                aux(0) <= not dezena(0);
    
                verificacao_dezena <= (aux(3) and ( aux(2) or aux(1)));
    
                if( verificacao_dezena = '0') then
    
                    E(0) <= aux(0);
                    E(1) <= aux(1);
                    E(2) <= aux(2);
                    E(3) <= aux(3);

                    carryOut <= '0';
                else
                    E(3) <= '0';
                    E(2) <=  (aux(3) and aux(2) and aux(1));
                    E(1) <=  (aux(3) and aux(2) and (not aux(1)));
                    E(0) <= ((aux(3) and aux(2)) and ( aux(1) or aux(0)));
                    
                    carryOut <= '1';
    
                end if;    
    
            elsif ((verificacao_unidade = '1') and (verificacao_dezena = '1' )) then
    
                F(3) <= '0';
                F(2) <=  (unidade(3) and unidade(2) and unidade(1));
                F(1) <=  (unidade(3) and unidade(2) and (not unidade(1)));
                F(0) <=  ((unidade(3) and unidade(2)) and ( unidade(1) or unidade(0)));
    
                E(3) <= ( ((not dezena(3)) and  (dezena(1) or dezena(0))) or  ( (dezena(3) xor dezena(2)) and  dezena(1) and dezena(0)) );
                E(2) <= ( ( (not dezena(2)) and dezena(1) and dezena(0)) or (dezena(2) and ( (not dezena(1)) or (dezena(1) and (not dezena(0)) ) ) )); 
                E(1) <= dezena(1) xor dezena(0);
                E(0) <= not dezena(0);
    
                E(3) <= '0';
                E(2) <=  (dezena(3) and dezena(2) and dezena(1));
                E(1) <=  (dezena(3) and dezena(2) and (not dezena(1)));
                E(0) <= (( dezena(3) and dezena(2)) and ( dezena(1) or dezena(0)));

                carryOut <= '0';
    
        
    
            elsif ((verificacao_dezena = '1') and (verificacao_unidade = '0')) then
    
                E(3) <= '0';
                E(2) <=  (dezena(3) and dezena(2) and dezena(1));
                E(1) <=  (dezena(3) and dezena(2) and (not dezena(1)));
                E(0) <=  (dezena(3) and dezena(2) and ( dezena(1) or dezena(0)));

                F(0) <= unidade(0);
                F(1) <= unidade(1);
                F(2) <= unidade(2);
                F(3) <= unidade(3);  

                carryOut <= '1';


            elsif ((verificacao_dezena = '0') and (verificacao_unidade = '0')) then
    
                F(0) <= unidade(0);
                F(1) <= unidade(1);
                F(2) <= unidade(2);
                F(3) <= unidade(3);
                
                E(0) <= dezena(0);
                E(1) <= dezena(1);
                E(2) <= dezena(2);
                E(3) <= dezena(3);  

                carryOut <= '0';
    
            end if;
    
        end process;
    



end arc_fatorCorrecao;