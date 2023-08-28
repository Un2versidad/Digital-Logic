library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec3a8 is
port (
    A: in std_logic;
    B: in std_logic_vector(2 downto 0);
    C: out std_logic_vector(7 downto 0)
);
end dec3a8;

architecture Behavioral of dec3a8 is
    signal ax: std_logic_vector(7 downto 0);
begin
    with B select
        ax <= "10000000" when "000",
              "01000000" when "001",
              "00100000" when "010",
              "00010000" when "011",
              "00001000" when "100",
              "00000100" when "110",
              "00000010" when others;

    C <= ax when (A = '0') else "00000000";
end Behavioral;
