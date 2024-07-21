----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1b is
    Port (A, B, Cin: in std_logic;
          Y, Cout: out std_logic);
end full_adder_1b;

architecture Behavioral of full_adder_1b is
    signal temp1, temp2, temp3: std_logic;
begin
    temp1 <= A xor B;
    Y <= temp1 xor Cin;
    temp2 <= Cin and temp1;
    temp3 <= A and B;
    Cout <= temp2 or temp3;
end Behavioral;
----------------------------------------------------------------------------------