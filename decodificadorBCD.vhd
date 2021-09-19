-- Arquivo que contém o decodificadorBCD

library ieee;
use ieee.std_logic_1164.ALL;

entity decodificadorBCD is

    port ( A : in std_logic_vector (3 downto 0); 	--entrada em hexadecimal
           B,C : out std_logic_vector (3 downto 0)	-- saida em BCD (B dezena e C unidade)
    );

end decodificadorBCD;


architecture code of decodificadorBCD is 
begin 
	with A select
	C <=        "0000" when "0000", -- 0
				"0001" when "0001", -- 1
				"0010" when "0010", -- 2
				"0011" when "0011", -- 3
				"0100" when "0100", -- 4
				"0101" when "0101", -- 5
				"0110" when "0110", -- 6 
				"0111" when "0111", -- 7
				"1000" when "1000", -- 8
				"1001" when "1001", -- 9
				"0000" when "1010", -- 0 | 10
				"0001" when "1011", -- 1 | 11
				"0010" when "1100", -- 2 | 12
				"0011" when "1101", -- 3 | 13
				"0100" when "1110", -- 4 | 14 
				"0101" when "1111"; -- 5 | 15

    with A select

    B <=        "0001" when "1010", -- 0 | 10
                "0001" when "1011", -- 1 | 11
                "0001" when "1100", -- 2 | 12
                "0001" when "1101", -- 3 | 13
                "0001" when "1110", -- 4 | 14 
                "0001" when "1111", -- 5 | 15
                "0000" when others;
end code;