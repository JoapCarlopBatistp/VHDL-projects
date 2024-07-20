----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity half_adder_1b is
--  Port ( );
end half_adder_1b;

architecture Behavioral of half_adder_1b is
component Half_Adder is
    Port (A, B: in std_logic;
          Y,Carry: out std_logic );
end component;

constant TIME_DELTA: time:= 10ns;
signal A_tb, B_tb: std_logic;
signal Y_tb, Carry_tb: std_logic;

begin

    dut: Half_Adder
        port map(
        A => A_tb,
        B => B_tb,
        Y => Y_tb,
        Carry => Carry_tb
        );

    simulation: process
    begin
    A_tb <= '0';
    B_tb <= '0';
    wait for TIME_DELTA;
    A_tb <= '0';
    B_tb <= '1';
    wait for TIME_DELTA;
    A_tb <= '1';
    B_tb <= '0';
    wait for TIME_DELTA;
    A_tb <= '1';
    B_tb <= '1';
    wait for TIME_DELTA;
    
    wait;
    end process simulation;
end Behavioral;
----------------------------------------------------------------------------------