library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity fullADDER is
port (A,B,Cin: in std_logic;
		S, Cout: out std_logic
	
	);

end fullADDER;

architecture logicaFullADDER of fullADDER is
begin

S <= (A xor B) xor Cin;
Cout <= (A and B) or (Cin and ( A or B ));

end logicaFullADDER;