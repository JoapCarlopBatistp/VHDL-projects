----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry_adder_8b is
    Port (A, B: in std_logic_vector(7 downto 0);
          Cin: in std_logic;
          Y: out std_logic_vector(7 downto 0);
          Cout: out std_logic);
end ripple_carry_adder_8b;

architecture Behavioral of ripple_carry_adder_8b is
    component full_adder_1b is
        Port (A, B, Cin: in std_logic;
              Y, Cout: out std_logic);
    end component;

    signal c1, c2, c3, c4, c5, c6, c7: std_logic;
begin
    F1: full_adder_1b port map (A(0), B(0), Cin, Y(0), c1);
    F2: full_adder_1b port map (A(1), B(1), C1, Y(1), c2);
    F3: full_adder_1b port map (A(2), B(2), C2, Y(2), c3);
    F4: full_adder_1b port map (A(3), B(3), C3, Y(3), c4);
    F5: full_adder_1b port map (A(4), B(4), C4, Y(4), c5);
    F6: full_adder_1b port map (A(5), B(5), C5, Y(5), c6);
    F7: full_adder_1b port map (A(6), B(6), C6, Y(6), c7);
    F8: full_adder_1b port map (A(7), B(7), C7, Y(7), Cout);
end Behavioral;
----------------------------------------------------------------------------------