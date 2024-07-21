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

entity ripple_carry_adder_8b_tb is
--  Port ( );
end ripple_carry_adder_8b_tb;

architecture Behavioral of ripple_carry_adder_8b_tb is
    component ripple_carry_adder_8b is
        Port(A,B: in std_logic_vector(7 downto 0);
             Cin: in std_logic;
             Y: out std_logic_vector(7 downto 0);
             Cout: out std_logic);
    end component;
    
    constant TIME_DELTA: time:= 20ns;
    signal A_tb,B_tb: std_logic_vector(7 downto 0);
    signal Cin_tb: std_logic := '0';
    
    signal Y_tb: std_logic_vector(7 downto 0);
    signal Cout_tb: std_logic;
begin
    
    dut: ripple_carry_adder_8b
        Port map(
        A => A_tb,
        B => B_tb,
        Cin => Cin_tb,
        Y => Y_tb,
        Cout => Cout_tb);
    
    simulation: process
    begin
        A_tb <= "00011100";
        B_tb <= "10110011";
        wait for TIME_DELTA;
        
        A_tb <= "10011101";
        B_tb <= "10110011";
        wait for TIME_DELTA;
        
        A_tb <= "11111111";
        B_tb <= "00000001";
        wait for TIME_DELTA;
        
        A_tb <= "00000000";
        B_tb <= "00000000";
        wait for TIME_DELTA;
        
        wait;
    end process simulation;

end Behavioral;
----------------------------------------------------------------------------------