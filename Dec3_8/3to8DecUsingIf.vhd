library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec3a8 is
    port (
        A, clk: in std_logic;
        B: in std_logic_vector(2 downto 0);
        C: out std_logic_vector(7 downto 0)
    );
end dec3a8;

architecture Behavioral of dec3a8 is
    signal ax: std_logic_vector(7 downto 0);
begin
    process(clk)
    begin
	If rising_edge(clk) then
        if (B = "000") then
            ax <= "10000000";
        elsif (B = "001") then
            ax <= "01000000";
        elsif (B = "010") then
            ax <= "00100000";
        elsif (B = "011") then
            ax <= "00010000";
        elsif (B = "100") then
            ax <= "00001000";
        elsif (B = "101") then
            ax <= "00000100";
		elsif (B = "110") then
            ax <= "00000010";
        else	 
            ax <= "00000001";
        end if;
		
	if A = '0' then
		C <= ax;
	else
		C <= "00000000";
	end if;
	
	end if;
    end process;
end Behavioral;