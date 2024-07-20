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

entity full_adder_1b_tb is
--  Port ( );
end full_adder_1b_tb;

architecture Behavioral of full_adder_1b_tb is
    component full_adder_1b is
        Port(A,B,Cin: in std_logic;
             Y, Cout: out std_logic);
    end component;
    
    constant TIME_DELTA: time := 10ns;
    signal A_tb, B_tb, Cin_tb: std_logic;
    signal Y_tb, Cout_tb: std_logic;
    
begin
    dut: full_adder_1b
    Port map(
    A => A_tb,
    B => B_tb,
    Cin => Cin_tb,
    Y => Y_tb,
    Cout => Cout_tb
    );
    
    simulation: process
    begin
        A_tb <= '0';
        B_tb <= '0';
        Cin_tb <= '0';
        wait for TIME_DELTA;
        A_tb <= '0';
        B_tb <= '0';
        Cin_tb <= '1';
        wait for TIME_DELTA;
        A_tb <= '0';
        B_tb <= '1';
        Cin_tb <= '0';
        wait for TIME_DELTA;
        A_tb <= '0';
        B_tb <= '1';
        Cin_tb <= '1';
        wait for TIME_DELTA;
        A_tb <= '1';
        B_tb <= '0';
        Cin_tb <= '0';
        wait for TIME_DELTA;
        A_tb <= '1';
        B_tb <= '0';
        Cin_tb <= '1';
        wait for TIME_DELTA;
        A_tb <= '1';
        B_tb <= '1';
        Cin_tb <= '0';
        wait for TIME_DELTA;
        A_tb <= '1';
        B_tb <= '1';
        Cin_tb <= '1';
        wait for TIME_DELTA;
        
        wait;
    end process simulation;

end Behavioral;
----------------------------------------------------------------------------------