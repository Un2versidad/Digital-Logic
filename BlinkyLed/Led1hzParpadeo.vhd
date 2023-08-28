library ieee;
use ieee.std_logic_1164.all;

entity frec is
    port (
        clk100mhz : in std_logic;
        led : out std_logic
    );
end frec;

architecture Behavioral of frec is
    signal led_count : integer range 0 to 268435455 := 0;
begin
    process (clk100mhz)
    begin
        if rising_edge(clk100mhz) then
            led_count <= led_count + 1;
            if led_count < 49999999 then
                led <= '0';
            elsif led_count >= 49999999 and led_count < 99999999 then
                led <= '1';
            else
                led <= '0';
                led_count <= 0;
            end if;
        end if;
    end process;
end Behavioral;