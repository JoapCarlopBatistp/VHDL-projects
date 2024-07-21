----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Half_Adder_1b is
    Port (A, B: in std_logic;
          Y,Carry: out std_logic );
end Half_Adder_1b;

architecture Behavioral of Half_Adder_1b is

begin
    carry <= A and B;
    Y <= A xor B;

end Behavioral;
----------------------------------------------------------------------------------
